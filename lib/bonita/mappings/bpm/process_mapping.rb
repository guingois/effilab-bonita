# frozen_string_literal: true
module Bonita
  module Bpm
    class ProcessMapping
      include Kartograph::DSL

      kartograph do
        mapping Process

        scoped :instantiated do
          property :caseId
        end

        scoped :read do
          property :id
          property :displayDescription
          property :deploymentDate
          property :description
          property :activationState
          property :name
          property :deployedBy
          property :displayName
          property :actorinitiatorid
          property :last_update_date
          property :configurationState
          property :version
        end
      end
    end
  end
end
