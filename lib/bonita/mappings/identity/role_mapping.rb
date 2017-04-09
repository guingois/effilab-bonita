# frozen_string_literal: true
module Bonita
  module Identity
    class RoleMapping
      include Kartograph::DSL

      kartograph do
        mapping Role

        scoped :read do
          property :id
          property :name
          property :displayName
          property :description
          property :creation_date
          property :created_by_user_id
          property :last_update_date
          property :icon
        end

        scoped :update, :create do
          property :name
          property :displayName
          property :description
          property :icon
        end
      end
    end
  end
end
