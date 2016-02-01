module Integral
  class Engine < ::Rails::Engine
    require 'haml'
    require 'simple_form'
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

    initializer "integral.assets.precompile" do |app|
        app.config.assets.precompile += %w(integral/application.scss)
    end
  end
end
