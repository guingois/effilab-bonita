# frozen_string_literal: true
module Bonita
  module Portal
    class ProfileMapping
      include Kartograph::DSL

      kartograph do
        mapping Profile

        scoped :read do
          property :createdBy
          property :creationDate
          property :description
          property :icon
          property :id
          property :is_default
          property :lastUpdateDate
          property :name
          property :updatedBy
        end

        scoped :create do
          property :description
          property :name
        end

        scoped :update do
          property :description
          property :id
          property :name
        end
      end
    end
  end
end
