# frozen_string_literal: true
module Bonita
  module Identity
    class Group < BaseModel
      attribute :created_by_user_id
      attribute :creation_date
      attribute :description
      attribute :displayName
      attribute :icon
      attribute :id
      attribute :last_update_date
      attribute :name
      attribute :parent_group_id
      attribute :parent_path
      attribute :path
    end
  end
end
