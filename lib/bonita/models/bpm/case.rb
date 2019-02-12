# frozen_string_literal: true

module Bonita
  module Bpm
    class Case < BaseModel
      attribute :activeFlowNodes
      attribute :end_date
      attribute :failedFlowNodes
      attribute :id
      attribute :last_update_date
      attribute :processDefinitionId
      attribute :rootCaseId
      attribute :searchIndex1Label
      attribute :searchIndex1Value
      attribute :searchIndex2Label
      attribute :searchIndex2Value
      attribute :searchIndex3Label
      attribute :searchIndex3Value
      attribute :searchIndex4Label
      attribute :searchIndex4Value
      attribute :searchIndex5Label
      attribute :searchIndex5Value
      attribute :start
      attribute :started_by
      attribute :startedBySubstitute
      attribute :state
      attribute :variables
    end
  end
end
