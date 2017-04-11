# frozen_string_literal: true
module Bonita
  module Portal
    # API reference : http://documentation.bonitasoft.com/?page=bpm-api#toc8
    class ProfileMemberResource < ResourceKit::Resource
      include ErrorHandler

      resources do
        action :create do
          path '/bonita/API/portal/profileMember'
          verb :post
          body { |object| ProfileMemberMapping.representation_for(:create, object) }
          handler(200) { |response| ProfileMemberMapping.extract_single(response.body, :read) }
        end

        action :search do
          query_keys :s, :f, :o, :d, :c
          path 'bonita/API/portal/profileMember'
          verb :get
          handler(200) { |response, payload| Bonita::Utils::SearchHandler.new(response, payload, self).call }
        end

        action :delete do
          path 'bonita/API/portal/profileMember/:profileMemberId'
          verb :delete
          handler(200) { true }
        end
      end
    end
  end
end
