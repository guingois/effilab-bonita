# frozen_string_literal: true

require "json"

module Fea
  # A callable object acting as a `::Logger::Formatter` that will format a
  # message into a JSON object.
  # @see #call
  # @api private
  class LogFormatter
    # @param severity  [String]
    # @param timestamp [Time]
    # @param progname  [String]
    # @param msg       [#to_json]
    # @return [String]
    def call(severity, timestamp, progname, msg)
      JSON.generate(
        tid: (Thread.current.object_id ^ Process.pid).to_s(36), # Sidekiq-style thread id
        severity: severity,
        timestamp: timestamp,
        progname: progname,
        msg: msg
      ) << "\n"
    end
  end
end
