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
          body { |object| UserMapping.representation_for(:create, object) }
          handler(200) { |response| ap UserMapping.extract_single(response.body, :read); UserMapping.extract_single(response.body, :read) }
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
          body { |object| UserMapping.representation_for(:update, object) }
          handler(200) { |response| UserMapping.extract_collection(response.body, :read) }
        end

        action :delete do
          path 'bonita/API/identity/user/:userId'
          verb :delete
          handler(200) { true }
        end
      end

      alias_method :find, :read
    end
  end
end
