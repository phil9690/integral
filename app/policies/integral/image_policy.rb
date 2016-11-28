module Integral
  # Handles Image authorization
  class ImagePolicy < BasePolicy
    # @return [Symbol] role name
    def role_name
      :image_manager
    end
  end
end
