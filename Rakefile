begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

Bundler::GemHelper.install_tasks

Dir[File.join(File.dirname(__FILE__), 'tasks/**/*.rake')].each { |f| load f }

# bundler-audit task
require 'bundler/audit/task'
Bundler::Audit::Task.new

# RuboCop task
require 'rubocop/rake_task'
desc 'Run all specs in spec directory (excluding plugin specs)'
RuboCop::RakeTask.new

# RSpec Task
require 'rspec/core'
require 'rspec/core/rake_task'
desc 'Run all specs in spec directory (excluding plugin specs)'
RSpec::Core::RakeTask.new do |t|
  t.verbose = false
end

task default: %i[bundle:audit rubocop spec]
