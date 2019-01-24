# frozen_string_literal: true

module Bonita
  module Bpm
    class CaseVariable < BaseModel
      attribute :case_id
      attribute :description
      attribute :name
      attribute :type
      attribute :value
    end
  end
end
