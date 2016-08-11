module Integral
  # Handles configurable settings within Integral
  class Configuration
    attr_accessor :black_listed_paths, :slack_web_hook_url

    def initialize
      set_defaults
    end

    private

    def set_defaults
      @black_listed_paths = [
        '/admin/'
      ]
    end
  end
end
