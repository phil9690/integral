$:.push File.expand_path("../lib", __FILE__)

require "integral/version"

Gem::Specification.new do |s|
  s.name        = "integral"
  s.version     = Integral::VERSION
  s.authors     = ["Patrick Lindsay"]
  s.email       = ["ptricklindsay@gmail.com"]
  s.homepage    = "https://github.com/patricklindsay/integral"
  s.summary     = "This gem packages together a variety of useful backend features and utilities integral for the foundation of any website or application."
  s.description = "Integral packages together all the basics to start a website or application so you don't have to.."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 4.2.4"
  s.add_dependency "devise", "3.5.1"
  s.add_dependency "pundit"

  s.add_dependency "haml-rails", "~> 0.9"
  s.add_dependency "sass-rails"
  s.add_dependency "materialize-sass"
  s.add_dependency "simple_form"
  s.add_dependency "client_side_validations"
  s.add_dependency "client_side_validations-simple_form"
  s.add_dependency "wice_grid"
  s.add_dependency "breadcrumbs_on_rails"

  s.add_development_dependency "pry-rails"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'faker'
  # s.add_development_dependency 'capybara'

  # CI, code coverage, analysis and documentation tools
  s.add_development_dependency 'fudge'
  s.add_development_dependency 'brakeman'
  s.add_development_dependency 'cane'
  s.add_development_dependency 'flog'
  s.add_development_dependency 'flay'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'simplecov'
end
