# frozen_string_literal: true
module Bonita
  class Error < StandardError
    attr_reader :java_exception, :error_message, :explanations, :status

    def initialize(status, body)
      if body['exception']
        mapping = Bonita::ErrorMapping.extract_single(body, :read)
        @java_exception = mapping.exception
        @error_message  = mapping.message
        @explanations   = mapping.explanations
        @status         = status
        values = Hash[instance_variables.map { |name| [name, instance_variable_get(name)] }]
      else
        values = body
      end

      super(values)
    end
  end

  AuthError         = Class.new(StandardError)
  UnauthorizedError = Class.new(StandardError)
  ForbiddenError    = Class.new(StandardError)
end
