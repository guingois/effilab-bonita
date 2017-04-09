# frozen_string_literal: true
module Bonita
  module Identity
    class GroupMapping
      include Kartograph::DSL

      kartograph do
        mapping Group

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

        scoped :create do
          property :icon
          property :name
          property :displayName
          property :parent_group_id
          property :description
        end

        scoped :update do
          property :name
          property :displayName
        end
      end
    end
  end
end
