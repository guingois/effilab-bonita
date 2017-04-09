# frozen_string_literal: true
module Bonita
  module Identity
    class UserMapping
      include Kartograph::DSL

      kartograph do
        mapping User

        scoped :read do
          property :id
          property :userName
          property :lastname
          property :firstname
          property :last_connection
          property :created_by_user_id
          property :creation_date
          property :icon
          property :title
          property :manager_id
          property :job_title
          property :last_update_date
          property :enabled
        end

        scoped :create do
          property :userName
          property :password
          property :password_confirm
          property :icon
          property :firstname
          property :lastname
          property :title
          property :job_title
          property :manager_id
        end

        scoped :update do
          property :id
          property :userName
          property :password
          property :password_confirm
          property :icon
          property :firstname
          property :lastname
          property :title
          property :job_title
          property :manager_id
        end
      end
    end
  end
end
