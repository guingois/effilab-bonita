# frozen_string_literal: true

module Bonita
  module Bpm
    class CaseVariableMapping
      include Kartograph::DSL

      kartograph do
        mapping CaseVariable

        scoped :read do
          property :case_id
          property :description
          property :name
          property :type
          property :value
        end

        scoped :update do
          property :type
          property :value
        end
      end
    end
  end
end
