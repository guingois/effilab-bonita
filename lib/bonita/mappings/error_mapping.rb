# frozen_string_literal: true
module Bonita
  class ErrorMapping
    Error = Struct.new(:exception, :message, :explanations)

    include Kartograph::DSL

    kartograph do
      mapping Error

      property :exception, scopes: [:read]
      property :message, scopes: [:read]
      property :explanations, scopes: [:read]
    end

    def self.fail_with(klass, content)
      error = extract_single(content, :read)
      raise klass, error.message
    end
  end
end
