# frozen_string_literal: true

require_relative "configuration"

module Fea
  # This mixin implements a thread-safe read/write `config` attribute to any object it extends.
  module Configurable
    # @api private
    def self.extended(object)
      object.instance_variable_set(:@config_mutex, Mutex.new)
      object.instance_variable_set(:@config, nil)
    end

    # @return [Configuration] The global configuration
    def config
      @config_mutex.synchronize do
        @config ||= Configuration.new
      end
    end

    # @overload def config=(options)
    #   Set a new {Configuration} instance initialized from a options hash as
    #   global configuration.
    #   @param value [Hash] The configuration options (see {Configuration#initialize})
    #
    # @overload def config=(configuration)
    #   Set some {Configuration} instance as global configuration.
    #   @param value [Configuration] A configuration object
    #
    # @return [void]
    def config=(value)
      config = value.is_a?(Configuration) ? value : Configuration.new(value)

      @config_mutex.synchronize do
        @config = config
      end
    end
  end

  extend Configurable
end
