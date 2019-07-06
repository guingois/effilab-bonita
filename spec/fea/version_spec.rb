# frozen_string_literal: true

require "fea/version"

RSpec.describe Fea::VERSION do
  subject { described_class }

  let(:source) do
    File.read(File.expand_path("../../VERSION", __dir__)).strip
  end

  it { is_expected.to be_a(Gem::Version) }

  it "matches the version source exactly" do
    expect(subject.to_s).to eq(source)
  end
end
