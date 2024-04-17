# frozen_string_literal: true

require "fea/configurable"

RSpec.describe Fea::Configurable do
  subject(:object) { Fea }

  describe "config" do
    def without_config
      previous_config = object.remove_instance_variable(:@config)
      object.instance_variable_set(:@config, nil)
      yield
      object.instance_variable_set(:@config, previous_config)
    end

    around do |example|
      without_config { example.run }
    end

    it "is a Configurable" do
      expect(object).to be_a(described_class)
    end

    it "is readable the first time" do
      expect(object.config).to be_a(Fea::Configuration)
    end

    it "is readable more than once" do
      config = object.config
      expect(object.config).to be(config)
    end

    it "is writable with another configuration" do
      config = Fea::Configuration.new
      object.config = config
      expect(object.config).to be(config)
    end

    it "is writable with options" do
      options = { username: double }
      object.config = options
      expect(object.config.username).to eq(options[:username])
    end
  end
end
