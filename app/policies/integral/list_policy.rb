module Integral
  # Handles List authorization
  class ListPolicy < BasePolicy
    def manager?
      user.has_role?(:list_manager)
    end
  end
end
