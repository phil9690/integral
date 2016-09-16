module Integral
  # Page view-level logic
  class PageDecorator < Draper::Decorator
    delegate_all

    # @return [String] formatted title
    def title
      object.title
    end

    # @return [String] formatted body
    def body
      object.body.html_safe
    end
  end
end
