# frozen_string_literal: true

require_relative "session"

module Fea
  # Module designed to extend classes that wrap an instance of {Session} on initialization.
  module Decorator
    # @example
    #   class UserService
    #     extend Decorator
    #
    #     def initialize(session)
    #       @session = session
    #     end
    #
    #     def get(user_id)
    #       @session.read(:identity, :user, user_id)
    #     end
    #   end
    #
    #   UserService.session { |service| service.get(1) }
    #
    # @see Session.start
    def session(*args)
      Session.start(*args) { |session| yield(new(session)) }
    end
  end
end
