# frozen_string_literal: true
module Bonita
  module Identity
    # API reference : http://documentation.bonitasoft.com/?page=bpm-api#toc36
    class UserResource < ResourceKit::Resource
      include ErrorHandler

      resources do
        action :create do
          path '/bonita/API/identity/user'
          verb :post
          body { |object| UserMapping.safe_representation_for(:create, object) }
          handler(200) { |response| UserMapping.extract_single(response.body, :read) }
        end

        action :read do
          path 'bonita/API/identity/user/:userId'
          verb :get
          handler(200) { |response| UserMapping.extract_single(response.body, :read) }
        end

        action :search do
          query_keys :s, :f, :o, :d, :c
          path 'bonita/API/identity/user'
          verb :get
          handler(200) { |response| UserMapping.extract_collection(response.body, :read) }
        end

        action :update do
          path 'bonita/API/identity/user/:userId'
          verb :put
          body { |object| Bonita::Utils::UpdateHandler.new(object, UserMapping).call }
          handler(200) { |response| UserMapping.extract_single(response.body, :read) }
        end

        action :delete do
          path 'bonita/API/identity/user/:userId'
          verb :delete
          handler(200) { true }
        end

        action :enable do
          path 'bonita/API/identity/user/:userId'
          verb :put
          body { |_object| { enabled: 'true' }.to_json }
          handler(200) { true }
        end

        action :disable do
          path 'bonita/API/identity/user/:userId'
          verb :put
          body { { enabled: 'false' }.to_json }
          handler(200) { true }
        end
      end
    end
  end
end
