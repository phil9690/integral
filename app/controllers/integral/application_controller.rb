module Integral
  class ApplicationController < ActionController::Base

    # Redirect user to integral.root_path after successful login
    def after_sign_in_path_for(resource)
      integral.root_path
    end
  end
end
