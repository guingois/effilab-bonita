# frozen_string_literal: true

module Fea
  version_str = File.read(
    File.expand_path("../../VERSION", __dir__)
  ).strip

  # The gem version.
  VERSION = Gem::Version.new(version_str)
end
