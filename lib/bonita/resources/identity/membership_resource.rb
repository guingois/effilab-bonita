# frozen_string_literal: true

module Bonita
  module Identity
    # API reference : http://documentation.bonitasoft.com/?page=bpm-api#toc8
    class MembershipResource < ResourceKit::Resource
      include ErrorHandler

      resources do
        action :search do
          query_keys :c, :d, :f, :o, :p, :s
          path "bonita/API/identity/membership"
          verb :get
          handler(200) { |response| MembershipMapping.extract_collection(response.body, :read) }
        end

        action :create do
          path "bonita/API/identity/membership"
          verb :post
          body { |object| MembershipMapping.safe_representation_for(:create, object) }
          handler(200) { |response| MembershipMapping.extract_single(response.body, :read) }
        end

        action :delete do
          path "bonita/API/identity/membership/:userId/:groupId/:roleId"
          verb :delete
          handler(200) { true }
        end
      end
    end
  end
end
