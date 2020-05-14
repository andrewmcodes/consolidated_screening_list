if ENV["COVERAGE"] || ENV["GITHUB_ACTIONS"]
  require "simplecov"
  require "coveralls"

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
    SimpleCov::Formatter::SimpleFormatter,
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ])

  SimpleCov.start do
    command_name "spec"
    add_filter "spec"
  end
end

require "bundler/setup"
require "webmock/rspec"
require "open3"
require "pry"
require "securerandom"
require "consolidated_screening_list"

WebMock.disable_net_connect!

module Helpers
  def with_env(key, value)
    old_env = ENV[key]
    ENV[key] = value
    yield
    ENV[key] = old_env
  end
end

RSpec.configure do |config|
  config.include(Helpers)
  # Turns deprecation warnings into errors, in order to surface the full backtrace of the call site.
  config.raise_errors_for_deprecations!
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"
  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
