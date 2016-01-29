module Integral
  class Engine < ::Rails::Engine
    require 'devise'

    isolate_namespace Integral

    config.generators do |g|
      g.test_framework :rspec
    end
  end
end
