# frozen_string_literal: true
module Bonita
  module Identity
    class RoleMapping
      include Kartograph::DSL

      kartograph do
        mapping Role

        property :id, scopes: %i(read)
        property :name, scopes: %i(read create update)
        property :displayName, scopes: %i(read create update)
        property :description, scopes: %i(read create update)
        property :creation_date, scopes: %i(read)
        property :created_by_user_id, scopes: %i(read)
        property :last_update_date, scopes: %i(read)
        property :icon, scopes: %i(read create update)
      end
    end
  end
end
