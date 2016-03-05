module Integral
  # Handles configurable settings within Integral
  class Configuration
    attr_accessor :file_storage_type

    def initialize
      @file_storage_type = :file
    end
  end
end
