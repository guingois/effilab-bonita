# frozen_string_literal: true
module Bonita
  module Bpm
    # API reference : http://documentation.bonitasoft.com/?page=bpm-api#toc27
    class ProcessResource < ResourceKit::Resource
      include ErrorHandler

      resources do
        action :instantiate, 'POST bonita/API/bpm/process/:processId/instantiation' do
          path 'bonita/API/bpm/process/:processId/instantiation'
          verb :post
          body { |object| object.to_json }
          handler(200) { |response| JSON.parse response.body }
        end

        action :search, 'GET /API/bpm/process' do
          query_keys :s, :f, :o, :d, :c
          path 'bonita/API/bpm/process'
          verb :get
          handler(200) { |response| ProcessMapping.extract_collection(response.body, :read) }
        end

        action :find, 'GET /API/bpm/process/:processId' do
          path 'bonita/API/bpm/process/:processId'
          verb :get
          handler(200) { |response| ProcessMapping.extract_single(response.body, :read) }
        end

        action :update, 'PUT /API/bpm/process/:processId' do
          path 'bonita/API/bpm/process/:processId'
          verb :put
          body { |object| object.is_a? Hash ? JSON.dump(object) : ProcessMapping.representation_for(:update, object) }
          handler(200) { |response| ProcessMapping.extract_single(response.body, :read) }
        end
      end

      alias_method :where, :search
      alias_method :read, :find
    end
  end
end
