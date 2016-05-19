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
    require 'carrierwave'
    require 'ckeditor'
    require 'friendly_id'
    require 'acts-as-taggable-on'

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
      assets_for_precompile = [
        "integral/application.scss",
        # Dashboard tiles
        "integral/tiles/posts.png",
        "integral/tiles/users.png",
        "integral/tiles/user.png",
        "integral/tiles/images.png",
        "integral/tiles/pages.png",
        # Defaults
        "integral/defaults/post_image.jpg",
        "integral/defaults/user_avatar.jpg",
        # CKEditor Overrides
        "ckeditor/my_contents.css",
        "ckeditor/my_styles.js",
        "ckeditor/my_config.js",
      ]

      app.config.assets.precompile.concat assets_for_precompile
    end
  end
end
