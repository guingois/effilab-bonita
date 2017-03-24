# frozen_string_literal: true
module Bonita
  module Customuserinfo
    class UserMapping
      include Kartograph::DSL

      kartograph do
        mapping User

        scoped :read do
          property :userId
          property :value
          property :definitionId, include: DefinitionMapping
        end
      end
    end
  end
end
