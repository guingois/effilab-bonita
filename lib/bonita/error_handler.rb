# frozen_string_literal: true
module ErrorHandler
  def self.included(base)
    base.send(:resources) do
      default_handler do |response|
        next if (200...299).cover?(response.status)
        case response.status
        when 401
          raise Bonita::UnauthorizedError, response.reason_phrase
        when 403
          raise Bonita::ForbiddenError, response.reason_phrase
        else
          raise Bonita::Error.new(response.status, response.body)
        end
      end
    end
  end
end
