# frozen_string_literal: true
module Bonita
  module Bdm
    # API reference : http://documentation.bonitasoft.com/?page=bdm-api#toc1
    class BusinessDataResource < ResourceKit::Resource
      include ErrorHandler

      resources do
        action :find do
          path 'bonita/API/bdm/businessData/:businessDataType/:persistenceId'
          verb :get
          handler(200) { |response| JSON.parse response.body }
        end
      end
    end
  end
end
