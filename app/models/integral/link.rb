module Integral
  class Link < MenuItem

    # Validations
    validates :title, :url, presence: true
  end
end
