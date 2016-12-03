module Integral
  # Handles Page authorization
  class PagePolicy < BasePolicy
    # @return [Symbol] role name
    def role_name
      :page_manager
    end
  end
end
