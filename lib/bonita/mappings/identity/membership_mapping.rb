# frozen_string_literal: true
module Bonita
  module Identity
    class MembershipMapping
      include Kartograph::DSL

      kartograph do
        mapping Membership

        property :role_id, scopes: %i(create read)
        property :group_id, scopes: %i(create read)
        property :user_id, scopes: %i(create read)
        property :assigned_date, scopes: %i(read)
        property :assigned_by_user_id, scopes: %i(read)
      end
    end
  end
end
