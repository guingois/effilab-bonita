# frozen_string_literal: true
module Bonita
  module Customuserinfo
    # API reference : http://documentation.bonitasoft.com/?page=customuserinfo-api#toc9
    class ValueResource < ResourceKit::Resource
      include ErrorHandler

      resources do
        action :associate_definition_to_user do
          path 'bonita/API/customuserinfo/value/:userId/:definitionId'
          verb :put
          body { |object| object.select { |k| k == :value }.to_json }
          handler(200) { true }
        end
      end
    end
  end
end
