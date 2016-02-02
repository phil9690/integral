module Integral
  # Handles User authorization definitions
  class UserPolicy
    attr_reader :user, :instance

    def initialize(user, instance)
      @user = user
      @instance = instance
    end

    def update?
      user.has_role?(:user_manager) || instance == user
    end

    def manager?
      user.has_role?(:user_manager)
    end

    alias_method :create?, :manager?
    alias_method :new?, :manager?
    alias_method :destroy?, :manager?
    alias_method :index?, :manager?

    alias_method :edit?, :update?
    alias_method :show?, :update?
  end
end
