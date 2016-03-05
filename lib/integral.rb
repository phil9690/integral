require 'devise'
require "integral/configuration"
require "integral/engine"

# Integral
module Integral

  # Enables engine configuration
  def self.configure
    yield(configuration)
  end

  class << self
    attr_writer :configuration
  end

  # Accessor for engine configuration
  def self.configuration
    @configuration ||= Configuration.new
  end
end
