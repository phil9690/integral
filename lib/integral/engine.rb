module Integral
  # Integral Engine
  class Engine < ::Rails::Engine
    require 'haml'
    require 'jquery-rails'
    require 'turbolinks'
    require 'simple_form'
    require 'cocoon'
    require 'client_side_validations'
    require 'client_side_validations/simple_form'
    require 'wice_grid'
    require 'breadcrumbs_on_rails'
    require 'materialize-sass'
    require 'materialize_builder'
    require 'pundit'
    require 'carrierwave'
    require 'carrierwave-imageoptimizer'
    require 'ckeditor'
    require 'friendly_id'
    require 'acts-as-taggable-on'
    require 'slack-notifier'

    isolate_namespace Integral

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    # Engine customization
    config.to_prepare do
      Dir.glob(Rails.root + "app/extensions/**/*_decorator*.rb").each do |c|
        require_dependency(c)
      end
    end

    # Allows engine factories to be reused by application
    initializer "model_core.factories", :after => "factory_girl.set_factory_paths" do
      FactoryGirl.definition_file_paths << File.expand_path('../../../spec/factories', __FILE__) if defined?(FactoryGirl)
    end

    initializer "integral.assets.precompile" do |app|
      assets_for_precompile = [
        "integral/application.scss",
        # Dashboard tiles
        "integral/tiles/*",
        # Defaults
        "integral/defaults/*",
        # CKEditor Overrides
        "ckeditor/my_contents.css",
        "ckeditor/my_styles.js",
        "ckeditor/my_config.js",
        "ckeditor/filebrowser/*"
      ]

      app.config.assets.precompile.concat assets_for_precompile
    end
  end
end
