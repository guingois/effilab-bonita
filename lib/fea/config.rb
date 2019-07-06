# frozen_string_literal: true

require_relative "configuration"

module Fea
  @confix_mutex = Mutex.new

  class << self
    # @return [Configuration] The global configuration
    def config
      @confix_mutex.synchronize do
        defined?(@config) ? @config : (@config = Configuration.new)
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

      @confix_mutex.synchronize do
        @config = config
      end
    end

    if ENV["FEA_TESTING"]
      def without_config
        if defined?(@config)
          memo = @config
          remove_instance_variable(:@config)
        end

        begin
          yield
        ensure
          @config = memo unless memo.nil?
        end
      end

      private :without_config
    end
  end
end
