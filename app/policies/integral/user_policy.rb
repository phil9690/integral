module Integral
  # Handles User authorization definitions
  class UserPolicy < BasePolicy
    # @return [Boolean] if user is allowed to perform an update
    def update?
      user.has_role?(:user_manager) || instance == user
    end

    # @return [Boolean] if user has manager role
    def manager?
      user.has_role?(:user_manager)
    end
  end
end
