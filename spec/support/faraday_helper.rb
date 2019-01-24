# frozen_string_literal: true

module Bonita::FaradayHelper
  # @see https://github.com/lostisland/faraday/issues/232#issuecomment-13429441
  # @param conn [Faraday::Connection]
  # @param adapter_class [Class] A test adapter class
  def stub_request(conn, adapter_class = Faraday::Adapter::Test, &stubs_block)
    adapter_handler = conn.builder.handlers.find { |h| h.klass < Faraday::Adapter }
    conn.builder.swap(adapter_handler, adapter_class, &stubs_block)
  end
end
