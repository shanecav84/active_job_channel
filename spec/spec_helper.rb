require 'rspec'
require 'active_job_channel'
require 'byebug' unless ENV['DEBUG'].nil?

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = :random
  Kernel.srand config.seed
end
