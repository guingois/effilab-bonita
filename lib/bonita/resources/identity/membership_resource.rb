# frozen_string_literal: true
module Bonita
  module Identity
    # API reference : http://documentation.bonitasoft.com/?page=bpm-api#toc8
    class MembershipResource < ResourceKit::Resource
      include ErrorHandler

      resources do
        action :create do
          path '/bonita/API/identity/membership'
          verb :post
          body { |object| MembershipMapping.safe_representation_for(:create, object) }
          handler(200) { |response| MembershipMapping.extract_single(response.body, :read) }
        end

        action :search do
          query_keys :s, :f, :o, :d, :c
          path 'bonita/API/identity/membership'
          verb :get
          handler(200) { |response, payload| Bonita::Utils::SearchHandler.new(response, payload, self).call }
        end

        action :delete do
          path 'bonita/API/identity/membership/:membershipId'
          verb :delete
          handler(200) { true }
        end
      end
    end
  end
end
