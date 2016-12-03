module Integral
  # List item which contains external or internal link
  class Link < ListItem

    # Validations
    validates :title, :url, presence: true
  end
end
