# frozen_string_literal: true

require "logger"
require "uri"

require_relative "log_formatter"

module Fea
  # Configuration class for a {Session}
  class Configuration
    # True if the connection should be secure
    # @return [Boolean]
    attr_accessor :use_ssl

    # The portal server host
    # @return [String]
    attr_accessor :host

    # The portal server port
    # @return [String]
    attr_accessor :port

    # The portal path (by default, `"/bonita"`)
    # @return [String]
    attr_accessor :path

    # The username used to authenticate sessions
    # @return [String]
    attr_accessor :username

    # The password used to authenticate sessions
    # @return [String]
    attr_accessor :password

    # The logger of sessions (by default, logs JSON messages to STDOUT at the DEBUG level)
    # @return [nil, Logger]
    attr_accessor :logger

    # @overload def initialize(opts)
    #   @param opts [Hash]
    #   @option opts [URI::HTTP, String] :url
    #   @option opts [String] :username
    #   @option opts [String] :password
    #   @option opts [nil, Logger] :logger
    #
    # @overload def initialize(opts)
    #   @param opts [Hash]
    #   @option opts [Boolean] :use_ssl
    #   @option opts [String] :host
    #   @option opts [String] :port
    #   @option opts [String] :path
    #   @option opts [String] :username
    #   @option opts [String] :password
    #   @option opts [nil, Logger] :logger
    def initialize(opts = {})
      if (url = opts.fetch(:url) { default_url })
        self.url = URI(url)
      else
        @use_ssl  = opts.fetch(:use_ssl) { default_use_ssl }
        @host     = opts.fetch(:host)    { default_host }
        @port     = opts.fetch(:port)    { default_port }
        @path     = opts.fetch(:path)    { default_path }
      end

      @username = opts.fetch(:username) { default_username }
      @password = opts.fetch(:password) { default_password }
      @logger   = opts.fetch(:logger)   { default_logger }
    end

    # @return [URI::HTTP]
    def url
      URI::HTTP.build(
        scheme: @use_ssl ? "https" : "http",
        host: @host,
        port: @port,
        path: @path
      )
    end

    # @param url [URI::HTTP, String]
    # @return [URI::HTTP]
    def url=(url)
      url = URI(url)

      @use_ssl = url.scheme == "https"
      @host    = url.host
      @port    = url.port
      @path    = url.path
    end

    # @param opts [Hash]
    # @return [self]
    def merge!(opts)
      if opts.key?(:url)
        self.url = opts[:url]
      else
        assign_if_key(:use_ssl, opts)
        assign_if_key(:host, opts)
        assign_if_key(:port, opts)
        assign_if_key(:path, opts)
      end

      assign_if_key(:username, opts)
      assign_if_key(:password, opts)
      assign_if_key(:logger, opts)

      self
    end

    # @param opts [Hash]
    # @return [Configuration]
    def merge(opts)
      dup.merge!(opts)
    end

    # @return [Hash]
    def to_h
      {
        use_ssl: use_ssl,
        host: host,
        port: port,
        path: path,
        username: username,
        password: password,
        logger: logger
      }
    end

    private

    def default_url
      ENV.key?("FEA_URL") ? URI(ENV["FEA_URL"]) : nil
    end

    def default_use_ssl
      ENV["FEA_USE_SSL"] == "true"
    end

    def default_host
      ENV.fetch("FEA_HOST", nil)
    end

    def default_port
      ENV.fetch("FEA_PORT", nil)
    end

    def default_path
      ENV.fetch("FEA_PATH", "/bonita")
    end

    def default_username
      ENV.fetch("FEA_USERNAME", nil)
    end

    def default_password
      ENV.fetch("FEA_PASSWORD", nil)
    end

    def default_logger
      logdev = ENV.fetch("FEA_LOGGER_DEVICE") { $stdout }
      return if logdev == ""

      Logger.new(logdev, level: Logger::DEBUG, formatter: LogFormatter.new)
    end

    def assign_if_key(key, value)
      public_send(:"#{key}=", value[key]) if value.key?(key)
    end
  end
end
