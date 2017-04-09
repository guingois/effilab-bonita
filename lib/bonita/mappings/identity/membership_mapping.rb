# frozen_string_literal: true
module Bonita
  module Identity
    class MembershipMapping
      include Kartograph::DSL

      kartograph do
        mapping Membership

        scoped :create do
          property :role_id
          property :group_id
          property :user_id
        end

        scoped :read do
          property :role_id
          property :group_id
          property :user_id
          property :assigned_date
          property :assigned_by_user_id
        end
      end
    end
  end
end
