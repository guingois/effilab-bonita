# frozen_string_literal: true
module Bonita
  module Bpm
    class Process < BaseModel
      attribute :activationState
      attribute :actorinitiatorid
      attribute :configurationState
      attribute :deployedBy
      attribute :deploymentDate
      attribute :description
      attribute :displayDescription
      attribute :displayName
      attribute :id
      attribute :last_update_date
      attribute :name
      attribute :version
    end
  end
end
