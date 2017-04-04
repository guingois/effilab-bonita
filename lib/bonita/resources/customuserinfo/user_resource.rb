# frozen_string_literal: true
module Bonita
  module Customuserinfo
    # API reference : http://documentation.bonitasoft.com/?page=customuserinfo-api#toc11
    class UserResource < ResourceKit::Resource
      include ErrorHandler

      resources do
        action :search do
          query_keys :s, :f, :o, :c
          path 'bonita/API/customuserinfo/user'
          verb :get
          handler(200) { |response| UserMapping.extract_collection(response.body, :read) }
        end
      end
    end
  end
end
