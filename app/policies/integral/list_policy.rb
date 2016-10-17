module Integral
  # Handles List authorization
  class ListPolicy
    attr_reader :user, :instance

    def initialize(user, instance)
      @user = user
      @instance = instance
    end

    def manager?
      user.has_role?(:image_manager)
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
