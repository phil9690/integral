module Integral
  class Basic < MenuItem

    # Validations
    validates :title, presence: true

    def basic?
      true
    end
  end
end
