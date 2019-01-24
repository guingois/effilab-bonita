# frozen_string_literal: true

module Bonita
  module Bpm
    class UserTask < BaseModel
      attribute :actorId
      attribute :assigned_date
      attribute :assigned_id
      attribute :caseId
      attribute :description
      attribute :displayDescription
      attribute :displayName
      attribute :dueDate
      attribute :executedBy
      attribute :executedBySubstitute
      attribute :id
      attribute :last_update_date
      attribute :name
      attribute :parentCaseId
      attribute :priority
      attribute :processId
      attribute :reached_state_date
      attribute :rootCaseId
      attribute :rootContainerId
      attribute :state
      attribute :type
    end
  end
end
