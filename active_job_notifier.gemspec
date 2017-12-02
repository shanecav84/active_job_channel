$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'active_job_notifier/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'active_job_notifier'
  s.version     = ActiveJobNotifier::VERSION
  s.authors     = ['Shane Cavanaugh']
  s.email       = ['shane@shanecav.net']
  s.summary     = 'Easily indicate a pending ActiveJob using ActionCable'
  s.license     = 'MIT'

  s.files = Dir[
    '{app,config,db,lib}/**/*',
    'MIT-LICENSE',
    'Rakefile',
    'README.md'
  ]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency 'rails', '>= 5.0.0'

  s.add_development_dependency 'byebug'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rubocop'
end
