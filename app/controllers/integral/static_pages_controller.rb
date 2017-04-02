module Integral
  # Static (not related to a specific model) pages
  class StaticPagesController < Integral.configuration.frontend_parent_controller.constantize

    # GET /
    # Homepage
    def home
    end
  end
end
