# frozen_string_literal: true

module Bonita
  class BaseModel
    class << self
      attr_reader :attributes

      def attribute(name)
        @attributes ||= []

        return if @attributes.include? name

        @attributes << name
        send(:attr_accessor, name)
      end
    end

    def initialize(params = {})
      self.class.attributes.each do |key|
        instance_variable_set("@#{key}", params[key])
      end
    end

    def inspect
      values = Hash[instance_variables.map { |name| [name, instance_variable_get(name)] }]
      "<#{self.class.name} #{values}>"
    end
  end
end
