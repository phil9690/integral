module Integral
  # Handles configurable settings within Integral
  class Configuration
    attr_accessor :black_listed_paths,
                  :slack_web_hook_url,
                  :backend_namespace,
                  :blog_enabled,
                  :blog_namespace,
                  :listable_objects,
                  :frontend_parent_controller,
                  # TODO: Change these settings to be configurable through backend
                  :facebook_app_id,
                  :twitter_handler,
                  :editor_image_size_limit,
                  :image_compression_quality,
                  :additional_page_templates


    def initialize
      set_defaults
    end

    private

    def set_defaults
      @backend_namespace = 'admin'
      @blog_enabled = true
      @blog_namespace = 'blog'
      @black_listed_paths = [
        '/admin/'
      ]

      @listable_objects = [
        'Integral::Post',
        'Integral::Page',
      ]

      @frontend_parent_controller = Integral::ApplicationController
      @editor_image_size_limit = [800, 800]
      @image_compression_quality = 90
      @additional_page_templates = []
    end
  end
end
