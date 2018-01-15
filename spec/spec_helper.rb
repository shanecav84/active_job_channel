require 'byebug' unless ENV['DEBUG'].nil?
ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../dummy/config/environment.rb', __FILE__)
require 'rspec'

RSpec.configure do |config|
  config.mock_with :rspec
  config.order = :random
  Kernel.srand config.seed
end
