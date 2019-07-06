# frozen_string_literal: true

module Fea
  # The superclass of all {Fea} error classes.
  #
  # Objects from the {Fea} module shouldn't raise other kinds of errors
  # than {Error} or its subclasses. A failure to that rule should be
  # considered an abstraction leak and a bug.
  #
  # @example Silence all errors that might come from objects from this module
  #   begin
  #     # whatever
  #   rescue Fea::Error
  #   end
  Error = Class.new(StandardError)

  # Raised when sending a request using an unsupported HTTP method.
  # @see Session::METHODS
  RequestMethodError = Class.new(Error)

  # Raised when a low-level failure happens (most likely, a network error).
  AdapterError = Class.new(Error)

  # Raised when the HTTP response couldn't be validated.
  # @see Exchange#validate
  ResponseError = Class.new(Error)

  # Raised when an attempt to authenticate a {Session} to Bonita fails.
  # @see Authentication#login
  AuthenticationError = Class.new(Error)

  # Raised when an request to Bonita is attempted without proper authentication.
  # @see Authentication#apply
  NotAuthenticatedError = Class.new(Error)
end
