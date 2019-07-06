# frozen_string_literal: true

module Fea
  version_str = File.read(
    File.expand_path("../../VERSION", __dir__)
  ).strip

  VERSION = Gem::Version.new(version_str)
end
