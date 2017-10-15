$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "pendant/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "pendant"
  s.version     = Pendant::VERSION
  s.authors     = ["Shane Cavanaugh"]
  s.email       = ["shane@shanecav.net"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Pendant."
  s.description = "TODO: Description of Pendant."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.4"

  s.add_development_dependency "sqlite3"
end
