module Integral
  # Integral Engine
  class Engine < ::Rails::Engine
    require 'haml'
    require 'simple_form'
    require 'cocoon'
    require 'client_side_validations'
    require 'client_side_validations/simple_form'
    require 'wice_grid'
    require 'breadcrumbs_on_rails'
    require 'materialize_builder'
    require 'pundit'

    isolate_namespace Integral

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end

    # Allows engine factories to be reused by application
    initializer "model_core.factories", :after => "factory_girl.set_factory_paths" do
      FactoryGirl.definition_file_paths << File.expand_path('../../../spec/factories', __FILE__) if defined?(FactoryGirl)
    end

    initializer "integral.assets.precompile" do |app|
        app.config.assets.precompile += %w(integral/application.scss users.png user.png)
    end
  end
end
