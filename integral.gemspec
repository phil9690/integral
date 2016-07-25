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
  s.add_dependency "turbolinks"
  s.add_dependency "devise" # Authentication
  s.add_dependency "devise_invitable" # Invitable authentication
  s.add_dependency "pundit" # Authorization
  s.add_dependency "haml-rails", "~> 0.9" # HAML
  s.add_dependency "sass-rails" # Sass
  s.add_dependency "materialize-sass", '~> 0.97.5.0' # Material Design UI framework
  s.add_dependency "simple_form" # Form builder
  s.add_dependency "cocoon" # Nested forms
  s.add_dependency "client_side_validations" # Client-side validations
  s.add_dependency "client_side_validations-simple_form" # Simpleform integration for Client-side validations
  s.add_dependency "wice_grid", "~> 3.5.0" # Grids
  s.add_dependency "breadcrumbs_on_rails" # Breadcrumbs
  s.add_dependency "carrierwave" # File uploader
  s.add_dependency "carrierwave-imageoptimizer" # Image compression
  s.add_dependency "ckeditor" # WYSIWYG Editor
  s.add_dependency "mini_magick" # File manipulation
  s.add_dependency "friendly_id" # Slugging
  s.add_dependency "acts-as-taggable-on", '~> 3.4' # Tagging

  s.add_development_dependency "pry-rails" # Debugger
  s.add_development_dependency "sqlite3" # Database
  s.add_development_dependency 'rspec-rails' # Testing framework
  s.add_development_dependency 'database_cleaner' # Manages database for consistent data setup
  s.add_development_dependency 'shoulda-matchers' # Extra matchers for testing
  s.add_development_dependency 'factory_girl_rails' # Create reusable object templates
  s.add_development_dependency 'faker' # Random data generator
  # s.add_development_dependency 'capybara'

  # CI, code coverage, analysis and documentation tools
  s.add_development_dependency 'fudge' # Build tool
  s.add_development_dependency 'brakeman' # Static security
  s.add_development_dependency 'cane' # Line length
  s.add_development_dependency 'flog' # Complexity
  s.add_development_dependency 'flay' # Duplication
  s.add_development_dependency 'yard' # Documentation
  s.add_development_dependency 'simplecov' # Coverage
end
