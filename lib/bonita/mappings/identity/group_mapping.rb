# frozen_string_literal: true
module Bonita
  module Identity
    class GroupMapping
      include Kartograph::DSL

      kartograph do
        mapping Group

        property :icon, scopes: %i(create)
        property :name, scopes: %i(create update)
        property :displayName, scopes: %i(create update)
        property :parent_group_id, scopes: %i(create)
        property :description, scopes: %i(create)

        scoped :read do
          property :id
          property :creation_date
          property :created_by_user_id
          property :icon
          property :description
          property :name
          property :path
          property :displayName
          property :parent_path
          property :parent_group_id
          property :last_update_date
        end
      end
    end
  end
end
