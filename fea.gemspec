# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name = "fea"
  spec.version = File.read("VERSION").strip
  spec.authors = ["Erwan Thomas"]
  spec.email = ["id@maen.fr"]

  spec.summary = "A Bonita REST API client for Ruby"
  spec.homepage = "https://github.com/guingois/fea"
  spec.license = "MIT"

  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = File.join(spec.homepage, "/blob/master/CHANGELOG.md")
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir.glob("lib/**/*").push("VERSION")
  spec.require_paths = ["lib"]
end
