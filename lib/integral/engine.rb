module Integral
  class Engine < ::Rails::Engine
    require 'devise'
    require 'haml'

    isolate_namespace Integral

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
    end
  end
end
