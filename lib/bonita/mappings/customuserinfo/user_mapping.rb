# frozen_string_literal: true
module Bonita
  module Customuserinfo
    class UserMapping
      include Kartograph::DSL

      kartograph do
        mapping User

        scoped :read do
          property :definitionId, include: DefinitionMapping
          property :userId
          property :value
        end
      end
    end
  end
end
