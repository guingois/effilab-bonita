# frozen_string_literal: true

module Bonita
  module Portal
    # API reference : http://documentation.bonitasoft.com/?page=bpm-api#toc36
    class ProfileResource < ResourceKit::Resource
      include ErrorHandler

      resources do
        action :create do
          path "/bonita/API/portal/profile"
          verb :post
          body { |object| ProfileMapping.safe_representation_for(:create, object) }
          handler(200) { |response| ProfileMapping.extract_single(response.body, :read) }
        end

        action :read do
          path "bonita/API/portal/profile/:profileId"
          verb :get
          handler(200) { |response| ProfileMapping.extract_single(response.body, :read) }
        end

        action :search do
          query_keys :s, :f, :o, :d, :c
          path "bonita/API/portal/profile"
          verb :get
          handler(200) { |response, payload| Bonita::Utils::SearchHandler.new(response, payload, self).call }
        end

        action :update do
          path "bonita/API/portal/profile/:profileId"
          verb :put
          body { |object| Bonita::Utils::UpdateHandler.new(object, ProfileMapping).call }
          handler(200) { |response| ProfileMapping.extract_single(response.body, :read) }
        end

        action :delete do
          path "bonita/API/portal/profile/:profileId"
          verb :delete
          handler(200) { true }
        end
      end
    end
  end
end
