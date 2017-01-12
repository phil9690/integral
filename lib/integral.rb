require 'devise'
require 'devise_invitable'

require "integral/version"
require "integral/configuration"
require "integral/engine"
require "integral/slack_bot"
require "integral/router"
require "integral/page_router"
require "integral/foundation_builder"
require "integral/list_renderer"
require "integral/swiper_list_renderer"
require "integral/list_item_renderer"
require "integral/partial_list_item_renderer"

require "simple_form/helpers/iconify"

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
