# frozen_string_literal: true
module Bonita
  module Identity
    class UserMapping
      include Kartograph::DSL

      kartograph do
        mapping User

        property :id, scope: %i(update)
        property :userName, scope: %i(update create)
        property :password, scope: %i(update create)
        property :password_confirm, scope: %i(update create)
        property :icon, scope: %i(update create)
        property :firstname, scope: %i(update create)
        property :lastname, scope: %i(update create)
        property :title, scope: %i(update create)
        property :job_title, scope: %i(update create)
        property :manager_id, scope: %i(update create)
        property :enabled, scope: %i(update create)

        scoped :read do
          property :last_connection
          property :created_by_user_id
          property :creation_date
          property :id
          property :icon
          property :enabled
          property :title
          property :manager_id
          property :job_title
          property :userName
          property :lastname
          property :firstname
          property :last_update_date
        end
      end
    end
  end
end
