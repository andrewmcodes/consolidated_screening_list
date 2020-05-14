require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "yaml"
require "yardstick/rake/measurement"
require "yardstick/rake/verify"

RSpec::Core::RakeTask.new(:spec)

desc "Run all specs"
task ci: %w[spec]

task default: :spec

Yardstick::Rake::Measurement.new(:yardstick_measure) do |measurement|
  measurement.output = "measurement/report.txt"
end

Yardstick::Rake::Verify.new(:verify_measurements, YAML.load_file(".yardstick.yml"))
