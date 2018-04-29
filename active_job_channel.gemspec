$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'active_job_channel/version'

Gem::Specification.new do |s|
  s.name = 'active_job_channel'
  s.version = ActiveJobChannel::VERSION
  s.authors = ['Shane Cavanaugh']
  s.email = ['shane@shanecav.net']
  s.summary = "Uses ActionCable to alert front-end users of ActiveJobs' status"
  s.license = 'MIT'

  s.files = Dir[
    '{app,config,lib}/**/*',
    'CHANGELOG.md',
    'MIT-LICENSE',
    'Rakefile',
    'README.md'
  ]
  s.test_files = Dir['spec/active_job_channel/**/*']

  s.required_ruby_version = '>= 2.2.2'

  # Earliest version that includes `ActionCable` and 'ActiveJob'
  s.add_dependency 'rails', '>= 5.0.0'

  s.add_development_dependency 'bundler-audit'
  s.add_development_dependency 'byebug'
  s.add_development_dependency 'puma' # Supports WebSockets for spec/dummy app
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rubocop'
end
