# frozen_string_literal: true

require "net/http"

require_relative "errors"

module Fea
  # `::Net::HTTP` operations might raise exceptions from several classes, mostly
  # due to input/output errors. Such errors cannot be easily rescued and
  # bubble up to users as abstraction leaks.
  #
  # {SafeHttp} subclasses `::Net::HTTP` and wraps its risky methods to make sure
  # they can only raise subclasses of {Error}, which are then easy to rescue.
  # @api private
  class SafeHttp < Net::HTTP
    # @note `::Net::HTTP#request` accepts a optional block, yielding the
    #   `::Net::HTTPResponse` object. {#request} honors that behavior, but
    #   users should be aware than _any_ error raised in the block will be
    #   wrapped in some kind of {Error}.
    def request(*)
      handle_adapter_errors { super }
    end

    private

    def handle_adapter_errors
      yield
    rescue StandardError => e
      raise AdapterError, "cause: #{e.inspect}"
    end

    def do_start
      handle_adapter_errors { super }
    end

    def do_finish
      handle_adapter_errors { super }
    end
  end
end
