# frozen_string_literal: true
module Bonita
  module Customuserinfo
    # API reference : http://documentation.bonitasoft.com/?page=bpm-api#toc27
    class DefinitionResource < ResourceKit::Resource
      include ErrorHandler

      resources do
        action :create do
          path 'bonita/API/customuserinfo/definition'
          verb :post
          body { |object| DefinitionMapping.safe_representation_for(:create, object) }
          handler(200) { |response| DefinitionMapping.extract_single(response.body, :read) }
        end

        action :delete do
          path 'bonita/API/customuserinfo/definition/:definitionId'
          verb :delete
          handler(200) { true }
        end

        action :all do
          query_keys :c, :p
          path 'bonita/API/customuserinfo/definition'
          verb :get
          handler(200) { |response| DefinitionMapping.extract_collection(response.body, :read) }
        end
      end
    end
  end
end
