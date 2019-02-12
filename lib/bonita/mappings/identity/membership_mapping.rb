# frozen_string_literal: true

module Bonita
  module Identity
    class MembershipMapping
      include Kartograph::DSL

      kartograph do
        mapping Membership

        scoped :read, :create_response do
          property :assigned_by_user_id
          property :assigned_date
          property :group_id
          property :user_id
        end

        property :role_id, scopes: [:create_response]
        property :role_id, include: RoleMapping, scopes: [:read]

        scoped :create do
          property :group_id
          property :role_id
          property :user_id
        end
      end
    end
  end
end
