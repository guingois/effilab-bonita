# frozen_string_literal: true

# 3rd party dependencies
require 'resource_kit'
require 'kartograph'
require 'faraday'
require 'faraday-cookie_jar'

# Utils
require 'bonita/utils'

# Error Handling
require 'bonita/mappings/error_mapping'
require 'bonita/error'
require 'bonita/error_handler'

# Models
require 'bonita/models/base_model'
require 'bonita/models/bpm/process'
require 'bonita/models/customuserinfo/definition'
require 'bonita/models/customuserinfo/value'
require 'bonita/models/customuserinfo/user'
require 'bonita/models/identity/user'
require 'bonita/models/identity/group'
require 'bonita/models/identity/role'
require 'bonita/models/identity/membership'

# JSON Maps
require 'bonita/mappings/bpm/process_mapping'
require 'bonita/mappings/customuserinfo/definition_mapping'
require 'bonita/mappings/customuserinfo/value_mapping'
require 'bonita/mappings/customuserinfo/user_mapping'
require 'bonita/mappings/identity/user_mapping'
require 'bonita/mappings/identity/group_mapping'
require 'bonita/mappings/identity/role_mapping'
require 'bonita/mappings/identity/membership_mapping'

# Resources
require 'bonita/resources/bpm/process_resource'
require 'bonita/resources/customuserinfo/definition_resource'
require 'bonita/resources/customuserinfo/value_resource'
require 'bonita/resources/customuserinfo/user_resource'
require 'bonita/resources/identity/user_resource'
require 'bonita/resources/identity/group_resource'
require 'bonita/resources/identity/role_resource'
require 'bonita/resources/identity/membership_resource'

require 'bonita/middleware/csrf'
require 'bonita/client'

module Bonita
end
