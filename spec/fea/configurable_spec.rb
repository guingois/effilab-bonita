# frozen_string_literal: true

require "fea/configurable"

RSpec.describe Fea::Configurable do
  subject { Fea }

  describe "config" do
    around do |example|
      subject.send(:without_config) { example.run }
    end

    it "is a Configurable" do
      expect(subject).to be_a(described_class)
    end

    it "is readable the first time" do
      expect(subject.config).to be_a(Fea::Configuration)
    end

    it "is readable more than once" do
      config = subject.config
      expect(subject.config).to be(config)
    end

    it "is writable with another configuration" do
      config = Fea::Configuration.new
      subject.config = config
      expect(subject.config).to be(config)
    end

    it "is writable with options" do
      options = { username: double }
      subject.config = options
      expect(subject.config.username).to eq(options[:username])
    end
  end
end
