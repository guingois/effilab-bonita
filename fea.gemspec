# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = "fea"
  spec.version       = File.read("VERSION").strip
  spec.authors       = ["Effilab"]

  spec.summary       = "A Bonita REST API client for Ruby"
  spec.homepage      = "https://github.com/effilab/fea"

  spec.metadata["homepage_uri"]    = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"]   = "#{spec.homepage}/blob/master/CHANGELOG.md"

  spec.files = ["VERSION", *Dir.glob("lib/**/*")]

  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rspec", "~> 3.8"
  spec.add_development_dependency "rspec_junit_formatter", "~> 0.4"
  spec.add_development_dependency "rubocop", "~> 0.72"
  spec.add_development_dependency "rubocop-rspec"
  spec.add_development_dependency "simplecov", "~> 0.17"
  spec.add_development_dependency "yard", "~> 0.9"
end
