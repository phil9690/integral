module Integral
  # Handles User authorization definitions
  class UserPolicy < BasePolicy
    # @return [Boolean] if user is allowed to perform an update
    def update?
      manager? || instance == user
    end

    # @return [Symbol] role name
    def role_name
      :user_manager
    end

    alias_method :edit?, :update?
    alias_method :show?, :update?
  end
end
