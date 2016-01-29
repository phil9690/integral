$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "integral/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "integral"
  s.version     = Integral::VERSION
  s.authors     = ["Patrick Lindsay"]
  s.email       = ["vindicated.fool@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Integral."
  s.description = "TODO: Description of Integral."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.4"

  s.add_development_dependency "sqlite3"
end
