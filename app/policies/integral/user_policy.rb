module Integral
  # Handles User authorization definitions
  class UserPolicy
    attr_reader :user, :instance

    # Initializes a UserPolicy instance which is used to handle authorization for User
    #
    # @param user [User] user policy is authorizing against
    # @param instance [User] instance policy is authorizing against
    def initialize(user, instance)
      @user = user
      @instance = instance
    end

    # @return [Boolean] if user is allowed to perform an update
    def update?
      user.has_role?(:user_manager) || instance == user
    end

    # @return [Boolean] if user has manager role
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
