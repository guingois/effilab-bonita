# frozen_string_literal: true

require "fea/session"

RSpec.describe Fea::Session do
  it "knows about a few HTTP methods" do
    expect(described_class::METHODS).to contain_exactly(:get, :post, :put, :delete)
  end

  describe "Fea::session" do
    it "starts a session easily" do
      args = [double]
      return_value = double
      block = proc { return_value }
      allow(described_class).to receive(:start).with(*args).and_yield
      expect(Fea.session(*args, &block)).to eq(return_value)
    end
  end
end
