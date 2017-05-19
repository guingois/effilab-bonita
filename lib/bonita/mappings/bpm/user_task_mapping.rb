# frozen_string_literal: true
module Bonita
  module Bpm
    class UserTaskMapping
      include Kartograph::DSL

      kartograph do
        mapping UserTask

        scoped :read do
          property :actorId
          property :assigned_date
          property :assigned_id
          property :caseId
          property :description
          property :displayDescription
          property :displayName
          property :dueDate
          property :executedBy
          property :executedBySubstitute
          property :id
          property :last_update_date
          property :name
          property :priority
          property :processId
          property :reached_state_date
          property :rootContainerId
          property :state
          property :type
        end

        scoped :update do
          property :assigned_id
          property :state
        end
      end
    end
  end
end
