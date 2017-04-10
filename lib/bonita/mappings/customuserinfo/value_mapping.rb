# frozen_string_literal: true
module Bonita
  module Customuserinfo
    class ValueMapping
      include Kartograph::DSL

      kartograph do
        mapping Value

        scoped :create do
          property :value
        end
      end
    end
  end
end
