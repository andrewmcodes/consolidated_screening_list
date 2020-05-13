require_relative "lib/consolidated_screening_list/version"

Gem::Specification.new do |spec|
  spec.name = "consolidated_screening_list"
  spec.version = ConsolidatedScreeningList::VERSION
  spec.authors = ["Andrew Mason"]
  spec.email = ["andrewmcodes@protonmail.com"]
  spec.summary = "A Ruby client for Trade.gov's Consolidated Screening List."
  spec.description = spec.summary
  spec.homepage = "https://github.com/andrewmcodes/consolidated_screening_list"
  spec.license = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")
  if spec.respond_to?(:metadata=)
    spec.metadata = {
      "allowed_push_host" => "https://rubygems.org",
      "bug_tracker_uri" => "#{spec.homepage}/issues",
      "homepage_uri" => spec.homepage,
      "source_code_uri" => spec.homepage
    }
  end
  spec.files = Dir["lib/**/*", "README.md", "LICENSE.txt"]
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Dependencies
  spec.add_dependency "rest-client", "~> 2"
  spec.add_dependency "iso_country_codes", "~> 0.7"
end
