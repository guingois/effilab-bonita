# frozen_string_literal: true

require_relative "fea/version"
require_relative "fea/session"
require_relative "fea/decorator"

# A Ruby client for the REST API of Bonita BPM Platform.
#
# {Fea::Session} is the actual client, please look at its documentation for more details.
#
# @example
#   Fea::Session.start do |session|
#     session.find(:identity, :user, filter: { userName: "foo@bar.baz" })
#   end
module Fea
end
