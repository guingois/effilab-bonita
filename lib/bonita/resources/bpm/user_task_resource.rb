# frozen_string_literal: true
module Bonita
  module Bpm
    # API reference : http://documentation.bonitasoft.com/?page=bpm-api#toc27
    class UserTaskResource < ResourceKit::Resource
      include ErrorHandler

      resources do
        action :find do
          path 'bonita/API/bpm/userTask/:userTaskId'
          verb :get
          handler(200) { |response| UserTaskMapping.extract_single(response.body, :read) }
        end

        action :update do
          path 'bonita/API/bpm/userTask/:userTaskId'
          verb :put
          body { |object| Bonita::Utils::UpdateHandler.new(object, UserTaskMapping).call }
          handler(200) { |response| UserTaskMapping.extract_single(response.body, :read) }
        end

        action :execution do
          path 'bonita/API/bpm/userTask/:userTaskId/execution'
          verb :post
          body { |object| object.to_json }
          handler(200) { |response| JSON.parse response.body }
        end

        action :context do
          path 'bonita/API/bpm/userTask/:userTaskId/context'
          verb :get
          handler(200) { |response| JSON.parse response.body }
        end
      end
    end
  end
end
