# frozen_string_literal: true

module Bonita
  module Bpm
    class CaseMapping
      include Kartograph::DSL

      kartograph do
        mapping Case

        scoped :read do
          property :activeFlowNodes
          property :end_date
          property :failedFlowNodes
          property :id
          property :last_update_date
          property :processDefinitionId
          property :rootCaseId
          property :searchIndex1Label
          property :searchIndex1Value
          property :searchIndex2Label
          property :searchIndex2Value
          property :searchIndex3Label
          property :searchIndex3Value
          property :searchIndex4Label
          property :searchIndex4Value
          property :searchIndex5Label
          property :searchIndex5Value
          property :start
          property :started_by
          property :startedBySubstitute
          property :state
        end

        scoped :create do
          property :processDefinitionId
          property :variables
        end
      end
    end
  end
end
