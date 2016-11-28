module Integral
  # Handles Image authorization
  class ImagePolicy < BasePolicy
    def manager?
      user.has_role?(:image_manager)
    end
  end
end
