# frozen_string_literal: true
module Bonita
  module Identity
    class User < BaseModel
      attribute :created_by_user_id
      attribute :creation_date
      attribute :enabled
      attribute :firstname
      attribute :icon
      attribute :icon
      attribute :id
      attribute :job_title
      attribute :last_connection
      attribute :last_update_date
      attribute :lastname
      attribute :manager_id
      attribute :password
      attribute :password_confirm
      attribute :title
      attribute :userName
    end
  end
end
