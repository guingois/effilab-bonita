# frozen_string_literal: true

# 3rd party dependencies
require 'resource_kit'
require 'kartograph'
require 'faraday'
require 'faraday-cookie_jar'

# Error Handling
require 'bonita/mappings/error_mapping'
require 'bonita/error'
require 'bonita/error_handler'

# Models
require 'bonita/models/base_model'
require 'bonita/models/bpm/process'
# JSON Maps
require 'bonita/mappings/bpm/process_mapping'
# Resources
require 'bonita/resources/bpm/process_resource'
require 'bonita/middleware/csrf'
require 'bonita/client'

module Bonita
end
