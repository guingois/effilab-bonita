class Hash
  # Replace nil values with empty strings recursively
  # @return [Hash]
  def denilize(h = self)
    h.each_with_object({}) do |(k, v), g|
      g[k] =
        if Hash === v
          denilize(v)
        else
          v ? v : ''
        end
    end
  end
end


module Kartograph::DSL::ClassMethods
  # Implementation of Kartograph::DSL#representation_for but replace nil values in object with empty strings
  def safe_representation_for(scope, object, dumper = Kartograph.default_dumper)
    dumper.dump(hash_for(scope, object).denilize)
  end
end

module Bonita
  module Utils
    module MappingResolver
      private

        def child_mapper(deploy)
          Object.const_get "#{namespace}::#{strip_prefix_and_suffix(deploy).capitalize}Mapping"
        end

        def mapper
          Object.const_get @resource.class.name.gsub('Resource', 'Mapping')
        end

        def namespace
          @resource.class.name.gsub(/::\w+Resource/, '')
        end

        # Given the following input strings :
        # foo_id
        # fooId
        # parent_foo_id
        # This method will always return 'foo'
        def strip_prefix_and_suffix(deploy)
          deploy.gsub(/Id|_id/, '').split('_')[-1]
        end
    end

    class UpdateHandler
      include MappingResolver

      def initialize(object, mapper)
        @object = object
        @mapper = mapper
      end

      def call
        if @object.is_a? Hash
          JSON.dump @object
        else
          @mapper.representation_for(:update, @object)
        end
      end
    end

    class SearchHandler
      include MappingResolver

      def initialize(response, payload, resource)
        @response = response
        @payload = payload
        @resource = resource
      end

      def call
        extract.map do |obj|
          @payload[:d].each do |deploy|
            obj.send("#{deploy}=", child_mapper(deploy).extract_single(obj.send(deploy).to_json, :read))
          end
          obj
        end
      end

      private

        def extract
          @extract ||= mapper.extract_collection(@response.body, :read)
        end
    end
  end
end
