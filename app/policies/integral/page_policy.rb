module Integral
  # Handles Page authorization
  class PagePolicy
    def manager?
      user.has_role?(:page_manager)
    end
  end
end
