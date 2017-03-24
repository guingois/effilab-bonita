# frozen_string_literal: true
module Bonita
  module Identity
    class User < BaseModel
      attribute :userName
      attribute :password
      attribute :password_confirm
      attribute :icon
      attribute :firstname
      attribute :lastname
      attribute :title
      attribute :job_title
      attribute :manager_id
      attribute :last_connection
      attribute :created_by_user_id
      attribute :creation_date
      attribute :id
      attribute :icon
      attribute :enabled
      attribute :last_update_date
    end
  end
end
