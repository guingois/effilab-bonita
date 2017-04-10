# frozen_string_literal: true
module Bonita
  module Identity
    class Membership < BaseModel
      attribute :assigned_by_user_id
      attribute :assigned_date
      attribute :group_id
      attribute :role_id
      attribute :user_id
    end
  end
end
