# frozen_string_literal: true

module Bonita
  module Portal
    class Profile < BaseModel
      attribute :createdBy
      attribute :creationDate
      attribute :description
      attribute :icon
      attribute :id
      attribute :is_default
      attribute :lastUpdateDate
      attribute :name
      attribute :updatedBy
    end
  end
end
