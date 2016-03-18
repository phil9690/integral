module Integral
  # Handles configurable settings within Integral
  class Configuration
    attr_accessor :black_listed_paths

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
