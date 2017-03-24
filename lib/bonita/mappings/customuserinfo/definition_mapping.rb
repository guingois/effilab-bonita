# frozen_string_literal: true
module Bonita
  module Customuserinfo
    class DefinitionMapping
      include Kartograph::DSL

      kartograph do
        mapping Definition

        scoped :create do
          property :name
          property :description
        end

        scoped :read do
          property :id
          property :name
          property :description
        end
      end
    end
  end
end
