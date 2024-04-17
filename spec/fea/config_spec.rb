# frozen_string_literal: true

require "fea/config"

RSpec.describe Fea do
  subject { described_class }

  describe "config" do
    around do |example|
      subject.send(:without_config) { example.run }
    end

    it "is readable the first time" do
      expect(subject.config).to be_a(subject::Configuration)
    end

    it "is readable more than once" do
      config = subject.config
      expect(subject.config).to be(config)
    end

    it "is writable with another configuration" do
      config = subject::Configuration.new
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
