module Integral
  class Link < ListItem

    # Validations
    validates :title, :url, presence: true
  end
end
