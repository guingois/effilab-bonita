# frozen_string_literal: true
module Bonita
  module Identity
    class Role < BaseModel
      attribute :id
      attribute :name
      attribute :displayName
      attribute :description
      attribute :creation_date
      attribute :created_by_user_id
      attribute :last_update_date
      attribute :icon
    end
  end
end
