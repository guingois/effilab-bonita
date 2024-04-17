# frozen_string_literal: true

require "fea/decorator"

RSpec.describe Fea::Decorator do
  subject(:decorated) do
    klass = Struct.new(:session)
    klass.extend(described_class)
    klass
  end

  it "simplifies decorating a session" do
    options = double
    session = double
    return_value = double

    allow(Fea::Session).to receive(:start).with(options).and_yield(session)

    result = decorated.session(options) do |instance|
      expect(instance.session).to be(session)
      return_value
    end

    expect(result).to be(return_value)
  end
end
