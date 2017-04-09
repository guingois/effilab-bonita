# frozen_string_literal: true
module Bonita
  class ErrorMapping
    Error = Struct.new(:exception, :message, :explanations)

    include Kartograph::DSL

    kartograph do
      mapping Error

      scoped :read do
        property :exception
        property :message
        property :explanations
      end
    end
  end
end
