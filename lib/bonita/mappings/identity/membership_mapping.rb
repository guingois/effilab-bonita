# frozen_string_literal: true
module Bonita
  module Identity
    class MembershipMapping
      include Kartograph::DSL

      kartograph do
        mapping Membership

        scoped :read do
          property :assigned_by_user_id
          property :assigned_date
          property :group_id
          property :role_id
          property :user_id
        end

        scoped :create do
          property :group_id
          property :role_id
          property :user_id
        end
      end
    end
  end
end
