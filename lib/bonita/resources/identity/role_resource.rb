# frozen_string_literal: true
module Bonita
  module Identity
    # API reference : http://documentation.bonitasoft.com/?page=bpm-api#toc26
    class RoleResource < ResourceKit::Resource
      include ErrorHandler

      resources do
        action :create do
          path '/bonita/API/identity/role'
          verb :post
          body { |object| RoleMapping.safe_representation_for(:create, object) }
          handler(200) { |response| RoleMapping.extract_single(response.body, :read) }
        end

        action :read do
          path 'bonita/API/identity/role/:roleId'
          verb :get
          handler(200) { |response| RoleMapping.extract_single(response.body, :read) }
        end

        action :search do
          query_keys :s, :f, :o, :d, :c
          path 'bonita/API/identity/role'
          verb :get
          handler(200) { |response|; RoleMapping.extract_collection(response.body, :read) }
        end

        action :update do
          path 'bonita/API/identity/role/:roleId/'
          verb :put
          body { |object| Bonita::Utils::UpdateHandler.new(object, RoleMapping).call }
          handler(200) { true }
        end

        action :delete do
          path 'bonita/API/identity/role/:roleId'
          verb :delete
          handler(200) { true }
        end
      end
    end
  end
end
