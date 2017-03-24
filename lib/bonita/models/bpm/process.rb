# frozen_string_literal: true
module Bonita
  module Bpm
    class Process < BaseModel
      attribute :id
      attribute :displayDescription
      attribute :deploymentDate
      attribute :description
      attribute :activationState
      attribute :name
      attribute :deployedBy
      attribute :displayName
      attribute :actorinitiatorid
      attribute :last_update_date
      attribute :configurationState
      attribute :version
    end
  end
end
