# frozen_string_literal: true
module Bonita
  module Bpm
    class ProcessMapping
      include Kartograph::DSL

      kartograph do
        mapping Process

        scoped :read do
          property :activationState
          property :actorinitiatorid
          property :configurationState
          property :deployedBy
          property :deploymentDate
          property :description
          property :displayDescription
          property :displayName
          property :id
          property :last_update_date
          property :name
          property :version
        end

        scoped :instantiated do
          property :caseId
        end
      end
    end
  end
end
