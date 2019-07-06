# frozen_string_literal: true

require "json"
require "net/http"

require_relative "errors"

module Fea
  # Wrap a pair of request/response sent over the network in a single entity.
  class Exchange
    PageInfo = Struct.new(:unit, :range, :size)

    attr_reader :host, :port, :request, :response

    # @param http [Net::HTTP]
    # @param request [Net::HTTPRequest]
    # @param response [Net::HTTPResponse]
    def initialize(http, request, response)
      @host = http.address
      @port = http.port
      @request = request
      @response = response
    end

    # The body sent with the request, parsed according to the request headers.
    # @return [nil, String, Hash, Array]
    def request_body
      defined?(@request_body) ? @request_body : (@request_body = parse_body(request))
    end

    # The body sent with the response, parsed according to the response headers.
    # @return [nil, String, Hash, Array]
    def response_body
      defined?(@response_body) ? @response_body : (@response_body = parse_body(response))
    end

    # Bonita's REST API does something weird (and apparently violates the [HTTP
    # specification](https://tools.ietf.org/html/rfc7233#section-4.2)) with the
    # `Content-Range` header to paginate search results and this method tries to
    # mitigate it by exposing a convenient pagination API for users.
    # @return [nil, PageInfo] nil if the response doesn't have a Content-Range header
    # @todo Handle header parsing errors properly
    def response_page_info
      content_range = response["Content-Range"]
      return unless content_range

      content_range.match(%r{(?:(\w+)\s+)?(\d+)-(\d+)/(\d+|\*)}i) do |match_data|
        unit = match_data[1]
        range_beg = Integer(match_data[2])
        range_end = Integer(match_data[3])
        size = match_data[4] == "*" ? nil : Integer(match_data[4])

        PageInfo.new(unit, range_beg..range_end, size)
      end
    end

    # Validate that the response is a success. A response is considered
    # successful when its status code belongs to the 2xx family.
    #
    # If the response is a success, the method returns the exchange immediately.
    #
    # Else, the method will raise an exception. Before raising the exception,
    # if a block is given, the method yields the exchange to the block.
    #
    # @yieldparam exchange [self] Yield itself if response isn't a success and a block is given
    # @return [self]
    # @raise {ResponseError} If the response isn't a success
    def validate
      return self if response.is_a?(Net::HTTPSuccess)

      yield(self) if block_given?

      error_msg = +"#{response.code} #{response.class.name.sub("Net::HTTP", "")}"
      if response_body.is_a?(Hash) && (api_msg = response_body[:message])
        error_msg << " [msg: #{api_msg}]"
      end

      raise ResponseError, error_msg
    end

    # Represent the exchange as a plain Hash made strictly from standard Ruby
    # objects.
    # @return [Hash]
    def to_h
      {
        host: host,
        port: port,
        request: {
          method: request.method,
          request_target: request.path,
          headers: request.to_hash,
          body: request_body,
        },
        response: {
          status_code: Integer(response.code),
          reason_phrase: presence(response.message),
          headers: response.to_hash,
          body: response_body,
        },
      }
    end

    private

    def presence(str)
      str.nil? || str.empty? ? nil : str
    end

    def parse_body(req_or_res)
      body = presence(req_or_res.body)
      return unless body

      content_type = req_or_res["Content-Type"]

      content_type.match(/charset=([^ ;]+)/i) do |match_data|
        charset = match_data.captures.first
        body.force_encoding(Encoding.find(charset))
      end

      case content_type
      when %r{application/json}
        JSON.parse(body, symbolize_names: true)
      else
        body
      end
    end
  end
end
