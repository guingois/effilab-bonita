# frozen_string_literal: true
module Bonita
  module Identity
    # API reference : http://documentation.bonitasoft.com/?page=bpm-api#toc8
    class GroupResource < ResourceKit::Resource
      include ErrorHandler

      resources do
        action :create do
          path '/bonita/API/identity/group'
          verb :post
          body { |object| GroupMapping.representation_for(:create, object) }
          handler(200) { |response| GroupMapping.extract_single(response.body, :read) }
        end

        action :read do
          path 'bonita/API/identity/group/:groupId'
          verb :get
          handler(200) { |response| GroupMapping.extract_single(response.body, :read) }
        end

        action :search do
          query_keys :s, :f, :o, :d, :c
          path 'bonita/API/identity/group'
          verb :get
          handler(200) { |response|; GroupMapping.extract_collection(response.body, :read) }
        end

        action :update do
          path 'bonita/API/identity/group/:groupId/'
          verb :put
          body { |object| Bonita::Utils::UpdateHandler.new(object, GroupMapping).call }
          handler(200) { |response| GroupMapping.extract_single(response.body, :read) }
        end
        action :delete do
          path 'bonita/API/identity/group/:groupId'
          verb :delete
          handler(200) { true }
        end
      end
    end
  end
end
