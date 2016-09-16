module Integral
  # Handles configurable settings within Integral
  class Configuration
    attr_accessor :black_listed_paths, :slack_web_hook_url, :website_url, :site_title, :facebook_app_id, :twitter_handler, :backend_namespace

    def initialize
      set_defaults
    end

    private

    def set_defaults
      @website_url = 'https://changemetoyourwebsiteurl.com'
      @site_title = 'Integral Rails'
      @backend_namespace = 'admin'
      @black_listed_paths = [
        '/admin/'
      ]
    end
  end
end
