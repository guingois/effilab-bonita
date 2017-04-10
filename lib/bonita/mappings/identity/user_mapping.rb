# frozen_string_literal: true
module Bonita
  module Identity
    class UserMapping
      include Kartograph::DSL

      kartograph do
        mapping User

        scoped :read do
          property :created_by_user_id
          property :creation_date
          property :enabled
          property :firstname
          property :icon
          property :id
          property :job_title
          property :last_connection
          property :last_update_date
          property :lastname
          property :manager_id
          property :title
          property :userName
        end

        scoped :create do
          property :firstname
          property :icon
          property :job_title
          property :lastname
          property :manager_id
          property :password
          property :password_confirm
          property :title
          property :userName
        end

        scoped :update do
          property :firstname
          property :icon
          property :id
          property :job_title
          property :lastname
          property :manager_id
          property :password
          property :password_confirm
          property :title
          property :userName
        end
      end
    end
  end
end
