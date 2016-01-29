module Integral
  class ApplicationController < ActionController::Base
    layout :layout_by_resource

    private

    # Redirect user to integral.root_path after successful login
    def after_sign_in_path_for(resource)
      integral.root_path
    end

    # Handle custom devise layouts
    # https://github.com/plataformatec/devise/wiki/How-To:-Create-custom-layouts
    # Can't do it pretty way as have no access to Application.rb within Engine
    # TODO: Add a spec for this
    def layout_by_resource
      if devise_controller?
        "integral/login"
      else
        "application"
      end
    end
  end
end
