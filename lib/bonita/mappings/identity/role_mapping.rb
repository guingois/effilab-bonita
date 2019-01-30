# frozen_string_literal: true

module Bonita
  module Identity
    class RoleMapping
      include Kartograph::DSL

      kartograph do
        mapping Role

        scoped :read do
          property :created_by_user_id
          property :creation_date
          property :description
          property :displayName
          property :icon
          property :id
          property :last_update_date
          property :name
        end

        scoped :update, :create do
          property :displayName
          property :name
        end

        scoped :create do
          property :description
          property :icon
        end
      end
    end
  end
end
