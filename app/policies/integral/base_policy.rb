module Integral
  # Sets base policy for all objects to inherit
  class BasePolicy
    attr_reader :user, :instance

    # Initializes a policy instance which is used to handle authorization
    #
    # @param user [User] user policy is authorizing against
    # @param instance [Object] instance policy is authorizing against
    def initialize(user, instance)
      @user = user
      @instance = instance
    end

    # @return [Boolean] whether or not user has manager role
    def manager?
      raise NotImplementedError
    end

    alias_method :destroy?, :manager?
    alias_method :index?, :manager?
    alias_method :show?, :manager?
    alias_method :new?, :manager?
    alias_method :create?, :manager?
    alias_method :edit?, :manager?
    alias_method :update?, :manager?
  end
end
