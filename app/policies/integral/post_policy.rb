module Integral
  # Handles Post authorization
  class PostPolicy
    def manager?
      user.has_role?(:post_manager)
    end
  end
end
