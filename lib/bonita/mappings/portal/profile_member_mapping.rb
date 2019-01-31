# frozen_string_literal: true

module Bonita
  module Portal
    class ProfileMemberMapping
      include Kartograph::DSL

      kartograph do
        mapping ProfileMember

        scoped :read do
          property :id
          property :profile_id
          property :role_id
          property :group_id
          property :user_id
          property :member_type
        end

        scoped :create do
          property :member_type
          property :profile_id
          property :user_id
        end
      end
    end
  end
end
