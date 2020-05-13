require "bundler/setup"
require "webmock/rspec"
require "open3"
require "pry"
require "securerandom"
require "consolidated_screening_list"
WebMock.disable_net_connect!

# def with_env(key, value)
#   old_env = ENV[key]
#   ENV[key] = value
#   yield
#   ENV[key] = old_env
# end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
