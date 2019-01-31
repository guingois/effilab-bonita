# frozen_string_literal: true

# 3rd party dependencies
require "resource_kit"
require "kartograph"
require "faraday"
require "faraday-cookie_jar"
require "byebug"
require "ap"

# Utils
require "bonita/utils"

# Error Handling
require "bonita/error_handler"
require "bonita/error"
require "bonita/mappings/error_mapping"

# Models
require "bonita/models/base_model"
require "bonita/models/bpm/case"
require "bonita/models/bpm/case_variable"
require "bonita/models/bpm/process"
require "bonita/models/bpm/user_task"
require "bonita/models/customuserinfo/definition"
require "bonita/models/customuserinfo/user"
require "bonita/models/customuserinfo/value"
require "bonita/models/identity/group"
require "bonita/models/identity/membership"
require "bonita/models/identity/role"
require "bonita/models/identity/user"
require "bonita/models/portal/profile"
require "bonita/models/portal/profile_member"

# JSON Maps
require "bonita/mappings/bpm/case_mapping"
require "bonita/mappings/bpm/case_variable_mapping"
require "bonita/mappings/bpm/process_mapping"
require "bonita/mappings/bpm/user_task_mapping"
require "bonita/mappings/customuserinfo/definition_mapping"
require "bonita/mappings/customuserinfo/user_mapping"
require "bonita/mappings/customuserinfo/value_mapping"
require "bonita/mappings/identity/group_mapping"
require "bonita/mappings/identity/role_mapping"
require "bonita/mappings/identity/membership_mapping"
require "bonita/mappings/identity/user_mapping"
require "bonita/mappings/portal/profile_mapping"
require "bonita/mappings/portal/profile_member_mapping"

# Resources
require "bonita/resources/bdm/business_data_resource"
require "bonita/resources/bpm/case_resource"
require "bonita/resources/bpm/case_variable_resource"
require "bonita/resources/bpm/process_resource"
require "bonita/resources/bpm/user_task_resource"
require "bonita/resources/customuserinfo/definition_resource"
require "bonita/resources/customuserinfo/user_resource"
require "bonita/resources/customuserinfo/value_resource"
require "bonita/resources/identity/group_resource"
require "bonita/resources/identity/membership_resource"
require "bonita/resources/identity/role_resource"
require "bonita/resources/identity/user_resource"
require "bonita/resources/portal/profile_resource"
require "bonita/resources/portal/profile_member_resource"

require "bonita/middleware/csrf"
require "bonita/client"

module Bonita
end
