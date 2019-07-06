# frozen_string_literal: true

require "net/http"

require_relative "config"
require_relative "errors"
require_relative "safe_http"
require_relative "authentication"
require_relative "exchange"

module Fea
  # Alias for {Session.start}. See there fore details.
  def self.session(*args, &block)
    Session.start(*args, &block)
  end

  # Wrap a HTTP connection in a client (called a `session`) that can
  # authenticate a user to Bonita's REST API and perform requests on its
  # behalf.
  #
  # The core of the session is the {#call} method. Other methods, such as
  # {#read}, {#search}, and so on, delegate most of the work to {#call}.
  class Session
    # The list of HTTP methods supported by a {Session}.
    # @see #call
    METHODS = %i[get post put delete].freeze

    METHOD_REQUESTS = METHODS.each_with_object(
      Hash.new { |method_token| raise RequestMethodError, method_token.inspect }
    ) do |method_token, map|
      map[method_token] = Net::HTTP.const_get(method_token.capitalize)
    end.freeze

    private_constant :METHOD_REQUESTS

    class << self
      # Open a HTTP connection to a Bonita REST API server, pass the
      # connection to a new {Session}, authenticate the session user, and
      # yield the session, now ready for any request. The session and its
      # connection are automatically closed at the end of the block.
      #
      # This is the primary way to initialize safely a {Session}.
      #
      # @param options [nil, Hash] Any missing option will be read from {Fea.config}
      #   See {Configuration} about the valid keys for `options`. Any invalid
      #   key will be ignored.
      # @yieldparam session [Session] A connected and authenticated session
      # @return [*] Whatever value the given block returns
      def start(options = nil)
        config = options ? Fea.config.merge(options) : Fea.config

        host = config.host
        port = config.port
        use_ssl = config.use_ssl
        session_opts = {
          username: config.username,
          password: config.password,
          portal_path: config.path,
          logger: config.logger,
        }

        SafeHttp.start(host, port, use_ssl: use_ssl) do |http|
          new(http, session_opts).login { |session| yield(session) }
        end
      end
    end

    # @param http [Net::HTTP] An HTTP connection to a Bonita REST API server
    # @param username [String] See {Configuration#username}
    # @param password [String] See {Configuration#password}
    # @param portal_path [String] See {Configuration#path}
    # @param logger [nil, Logger] See {Configuration#logger}
    def initialize(http, username:, password:, portal_path:, logger: nil)
      authentication = Authentication.new(
        username, password, portal_path: portal_path, logger: logger
      )

      @http = http
      @logger = logger
      @authentication = authentication
      @portal_path = portal_path
      @api_path = File.join(portal_path, "API")
    end

    # @!group Authentication operations

    # Authenticate the session with the username and password given at
    # initialization.
    #
    # When given a block, yields the session and automatically logs out at
    # the end of the block. The method will then return the value returned by
    # the block.
    #
    # When not given a block, returns `nil` immediately after login. The
    # session will stay authenticated until {#logout} is called.
    #
    # @yieldparam session [self] If a block is given
    # @return [nil, *] The block return value if a block is given, `nil` otherwise
    # @raise [AuthenticationError] If the authentication attempt is rejected
    # @see Authentication#login
    def login
      @authentication.login(@http)
      return unless block_given?

      begin
        yield(self)
      ensure
        logout
      end
    end

    # Deauthenticate a session previously authenticated with {#login}.
    #
    # @return [nil]
    # @raise [NotAuthenticatedError] If the session is not authenticated
    # @see Authentication#logout
    def logout
      @authentication.logout(@http)
    end

    # @!endgroup

    # Prepare and send a request to the REST API server. This is the core
    # method of the class, on which most others are built. It is public, and could
    # be use directly in a codebase, but you should probably prefer using the
    # specialized methods instead.
    #
    # This method can raise different kinds of exceptions (related to
    # authentication, network or response validation failures) but it should
    # honor the global {Fea} contract of only raising kinds of {Error}.
    #
    # @param method_token [Symbol] One of {Session::METHODS}
    # @!macro [new] call_resource_path_param
    #   @param resource_path [Array<#to_s>] The API endpoint path parts,
    #     starting with the resource API name
    # @param query [nil, Array, Hash] Unless nil, some value compatible
    #   with `::URI.encode_www_form(query)`
    # @!macro [new] call_data_param
    #   @param data [nil, #to_json] Unless nil, some value compatible with `::JSON.dump(data)`
    # @param strict [Boolean] If true, will validate responses with {Exchange#validate}
    # @param root_path [String] The REST API root_path (by default: `"#!{portal_path}/API"`)
    # @yieldparam request [Net::HTTPRequest] Yields the request right before
    #   sending it if a block is given
    # @return [Exchange]
    # @see #read
    # @see #create
    # @see #update
    # @see #delete
    # @see #search
    # @see #find
    # @see #upload
    def call(method_token, resource_path, query: nil, data: nil, strict: true, root_path: @api_path)
      request = configure_request(method_token, root_path, resource_path, query, data)
      yield(request) if block_given?

      exchange = Exchange.new(@http, request, @http.request(request))
      @logger&.debug { exchange.to_h }

      strict ? validate_exchange(exchange) : exchange
    end

    # @!group API resource operations

    # @!macro [new] resource_operation_return_value
    #   @return [*] See {Exchange#response_body}

    # Generic resource read operation.
    # @!macro call_resource_path_param
    # @!macro resource_operation_return_value
    # @see https://documentation.bonitasoft.com/bonita/7.9/rest-api-overview#toc7
    def read(*resource_path)
      call(:get, resource_path).response_body
    end

    # Generic resource creation operation.
    # @!macro call_resource_path_param
    # @!macro call_data_param
    # @!macro resource_operation_return_value
    # @see https://documentation.bonitasoft.com/bonita/7.9/rest-api-overview#toc6
    def create(*resource_path, data)
      call(:post, resource_path, data: data).response_body
    end

    # Generic resource update operation.
    # @!macro call_resource_path_param
    # @!macro call_data_param
    # @!macro resource_operation_return_value
    # @see https://documentation.bonitasoft.com/bonita/7.9/rest-api-overview#toc10
    def update(*resource_path, data)
      call(:put, resource_path, data: data).response_body
    end

    # Generic resource delete operation.
    # @!macro call_resource_path_param
    # @!macro resource_operation_return_value
    # @see https://documentation.bonitasoft.com/bonita/7.9/rest-api-overview#toc12
    def delete(*resource_path)
      call(:delete, resource_path).response_body
    end

    # Generic resource search operation.
    # @!macro call_resource_path_param
    # @param count [Integer] The maximum number of elements to retrieve
    # @param page [nil, Integer] The index of the page to display
    # @param order [nil, String] The order of presentation of values
    # @param search [nil, String] The word to search on name or search indexes
    # @param filter [nil, String, Array<String>, Hash{#to_s => #to_s}] The list of filters
    # @!macro resource_operation_return_value
    # @see https://documentation.bonitasoft.com/bonita/7.9/rest-api-overview#toc13
    # @todo add auto-pagination or expose the response page info somehow
    def search(*resource_path, count: 100, page: nil, order: nil, search: nil, filter: nil)
      query = { c: count }
      query[:p] = page if page
      query[:o] = order if order
      query[:s] = search if search

      if filter&.is_a?(Hash)
        query[:f] = filter.each_with_object([]) { |(k, v), acc| acc << "#{k}=#{v}" }
      elsif filter
        query[:f] = filter
      end

      call(:get, resource_path, query: query) do |request|
        # Net::HTTP default behavior and Bonita REST API search feature are in conflict.
        #
        # Bonita's REST API uses the Content-Range header to implement
        # paginated responses on search requests.
        #
        # Net::HTTP on the other hand considers that responses with a
        # Content-Range header set should be passed to the user without any
        # change to their encoding (as opposed to the default behavior of
        # decompressing automatically compressed bodies).
        #
        # Since search requests might, by default, be returned from the API
        # encoded with the gzip encoding, we'd then have to deal directly
        # with gzip'ed bodies and decompress them. Net::HTTP doesn't expose a
        # nice public API to do that and it would mean having to implement
        # the whole thing in the RestAPI module. It's a tedious and probably
        # useless task, so we force API responses to never be compressed in
        # search requests with the `Accept-Encoding: identity` header.
        #
        # @see https://docs.ruby-lang.org/en/2.6.0/Net/HTTP.html#class-Net::HTTP-label-Compression
        # @see https://documentation.bonitasoft.com/bonita/7.9/rest-api-overview#toc13
        request["Accept-Encoding"] = "identity"
      end.response_body
    end

    # Shortcut for a {#search} returning its first element.
    # @see #search
    def find(*resource_path, **options)
      search(*resource_path, count: 1, **options).first
    end

    # Generic file upload operation.
    # @param upload_path [Array<#to_s>] The upload servlet path, starting
    #   *after* the `portal` root path
    # @param file [File] The file to be uploaded
    # @return [String] The uploaded file path on the server
    # @see https://documentation.bonitasoft.com/bonita/7.9/manage-files-using-upload-servlet-and-rest-api
    def upload(*upload_path, file)
      raise ArgumentError, "Expected File, got #{file.class}" unless file.is_a?(File)

      field_name = "file"
      field_value = file
      form_data = [[field_name, field_value]]

      call(:post, upload_path, root_path: @portal_path) do |request|
        request["Accept"] = "text/plain"
        request.set_form(form_data, "multipart/form-data")
      end.response_body
    end

    # @!endgroup

    private

    def build_path(root_path, parts, query = nil)
      path = File.join(root_path, *parts.map!(&:to_s))
      return path unless query

      path << "?#{URI.encode_www_form(query)}"
    end

    def configure_request(method_token, root_path, resource_path, query, data)
      request = METHOD_REQUESTS[method_token].new(build_path(root_path, resource_path, query))
      request["Accept"] = "application/json"
      @authentication.apply(request)

      if data
        request["Content-Type"] = "application/json; charset=utf-8"
        request.body = JSON.dump(data)
      end

      request
    end

    def validate_exchange(exchange)
      exchange.validate do
        # directly mutate the request, it won't be available after the end of the block anyway
        @authentication.purge(exchange.request)
        @logger&.warn { exchange.to_h }
      end
    end
  end
end
