# frozen_string_literal: true
module Bonita
  module Identity
    class GroupMapping
      include Kartograph::DSL

      kartograph do
        mapping Group

        scoped :read do
          property :created_by_user_id
          property :creation_date
          property :description
          property :displayName
          property :icon
          property :id
          property :last_update_date
          property :name
          property :parent_group_id
          property :parent_path
          property :path
        end

        scoped :create do
          property :description
          property :displayName
          property :icon
          property :name
          property :parent_group_id
        end

        scoped :update do
          property :displayName
          property :name
        end
      end
    end
  end
end
