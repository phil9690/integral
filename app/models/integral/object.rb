module Integral
  class Object < MenuItem
    # Validations
    validates :object_type, :object_id, presence: true

    def object?
      true
    end

    # Calculate the object class associated to the menu item based on numeric value set within the modal
    # A numeric value is used rather than setting the actual class for security purposes
    def object_klass
      object_type.constantize
    end
  end
end
