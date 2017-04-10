# frozen_string_literal: true
module Bonita
  module Customuserinfo
    class DefinitionMapping
      include Kartograph::DSL

      kartograph do
        mapping Definition

        scoped :read do
          property :description
          property :id
          property :name
        end

        scoped :create do
          property :description
          property :name
        end
      end
    end
  end
end
