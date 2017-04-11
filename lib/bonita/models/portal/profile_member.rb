# frozen_string_literal: true
module Bonita
  module Portal
    class ProfileMember < BaseModel
      attribute :id
      attribute :profile_id
      attribute :role_id
      attribute :group_id
      attribute :member_type
      attribute :user_id
    end
  end
end
