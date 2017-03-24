# frozen_string_literal: true
require 'virtus'

module Bonita
  class BaseModel
    include Virtus.model

    def inspect
      values = Hash[instance_variables.map { |name| [name, instance_variable_get(name)] }]
      "<#{self.class.name} #{values}>"
    end
  end
end
