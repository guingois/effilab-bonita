# frozen_string_literal: true
module Bonita
  module Identity
    class UserMapping
      include Kartograph::DSL

      kartograph do
        mapping User

        property :id, scopes: %i(update)
        property :userName, scopes: %i(update create)
        property :password, scopes: %i(update create)
        property :password_confirm, scopes: %i(update create)
        property :icon, scopes: %i(update create)
        property :firstname, scopes: %i(update create)
        property :lastname, scopes: %i(update create)
        property :title, scopes: %i(update create)
        property :job_title, scopes: %i(update create)
        property :manager_id, scopes: %i(update create)
        property :enabled, scopes: %i(update create)

        property :enabled, scope: :enabled

        scoped :read do
          property :last_connection
          property :created_by_user_id
          property :creation_date
          property :id
          property :icon
          property :title
          property :manager_id
          property :job_title
          property :userName
          property :lastname
          property :firstname
          property :last_update_date
          property :enabled
        end
      end
    end
  end
end
