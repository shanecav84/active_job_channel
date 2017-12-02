$LOAD_PATH.push File.expand_path('../lib', __FILE__)

require 'active_job_notifier/version'

Gem::Specification.new do |s|
  s.name        = 'active_job_notifier'
  s.version     = ActiveJobNotifier::VERSION
  s.authors     = ['Shane Cavanaugh']
  s.email       = ['shane@shanecav.net']
  s.summary     = 'Uses `ActionCable` to alert front-end users of finished `ActiveJobs`'
  s.license     = 'MIT'

  s.files = Dir[
    '{app,config,lib}/**/*',
    'MIT-LICENSE',
    'Rakefile',
    'README.md'
  ]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency 'rails', '>= 5.0.0' # Earliest version that includes `ActionCable`

  s.add_development_dependency 'byebug'
  s.add_development_dependency 'puma'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rubocop'
end
