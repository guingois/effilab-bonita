# frozen_string_literal: true

require "net/http"

require_relative "errors"
require_relative "exchange"

module Fea
  # Represent the authentication part of a session.
  #
  # It works as a kind of state machine:
  #
  # - *step 1* {#login}
  # - *step 2* {#apply} or {#purge} (repeat as needed)
  # - *step 3* {#logout}
  # - *step 4* back to *step 1* if needed
  class Authentication
    # @param username [String]
    # @param password [String]
    # @param portal_path [String] The root path of the Bonita Portal (most likely `"/bonita"`)
    # @param logger [nil, Logger]
    def initialize(username, password, portal_path:, logger: nil)
      @username = username
      @password = password
      @portal_path = portal_path
      @logger = logger
      @headers = nil
    end

    # Send a login request using the given connection and store
    # authentication data from the response that will be applied later to
    # requests.
    # @param http [Net::HTTP]
    # @return [nil]
    # @raise [AuthenticationError] If the login information are invalid
    # @raise [ResponseError] If the request is not a success
    def login(http)
      request = Net::HTTP::Post.new(File.join(@portal_path, "loginservice"))
      request.set_form_data(
        "username" => @username,
        "password" => @password,
        "redirect" => "false"
      )

      exchange = Exchange.new(http, request, http.request(request))
      @logger&.debug { exchange.to_h }

      if exchange.response.is_a?(Net::HTTPUnauthorized)
        raise AuthenticationError, "Invalid username/password ?"
      end

      exchange.validate
      @headers = parse_cookies(exchange.response.get_fields("Set-Cookie"))
      nil
    end

    # Is the authentication successful ?
    # @return [Boolean]
    def logged_in?
      !@headers.nil?
    end

    # Apply authentication data to the request settings
    # @param request [Net::HTTPRequest]
    # @return [Net::HTTPRequest] The given request
    # raise [NotAuthenticatedError] If the authentication isn't valid
    def apply(request)
      headers = get_headers!
      headers.each { |k, v| request[k] = v }
      request
    end

    # Purge authentication data from the request settings
    # @param request [Net::HTTPRequest]
    # @return [Net::HTTPRequest] The given request
    # raise [NotAuthenticatedError] If the authentication isn't valid
    def purge(request)
      headers = get_headers!
      headers.each_key { |k| request[k] = "HIDDEN" }
      request
    end

    # Send a logout request using the given connection and clear previously
    # stored authentication data.
    # @param http [Net::HTTP]
    # @return [nil]
    # @raise [ResponseError] If the request is not a success
    def logout(http)
      request = Net::HTTP::Get.new(File.join(@portal_path, "logoutservice?redirect=false"))
      request["Cookie"] = get_headers!["Cookie"]
      # request doesn't have a body, but Net::HTTP will emit a warning
      # without a Content-Type, so here's a dummy one.
      request["Content-Type"] = "text/plain"
      exchange = Exchange.new(http, request, http.request(request))
      @logger&.debug { exchange.to_h }
      exchange.validate
      @headers = nil
    end

    private

    def get_headers!
      @headers || raise(NotAuthenticatedError)
    end

    def parse_cookies(set_cookie_headers)
      headers = { "Cookie" => [] }

      set_cookie_headers.map { |cookie| cookie.split(";").first }.each do |cookie|
        if cookie.start_with?("X-Bonita-API-Token=")
          key, value = cookie.split("=")
          headers[key] = value
        else
          headers["Cookie"] << cookie
        end
      end

      headers["Cookie"] = headers["Cookie"].join("; ")

      headers
    end
  end
end
