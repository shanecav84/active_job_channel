require 'bundler/setup'
Bundler.setup

require 'active_job_channel'

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = :random
  Kernel.srand config.seed
end
