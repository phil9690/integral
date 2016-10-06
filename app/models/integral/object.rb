module Integral
  class Object < MenuItem
    # Validations
    validates :object_type, :object_id, presence: true


    # This is view stuff which should be moved out into some sort of menuitempresenter
    def title
      override = super
      return override if override.present?

      object_klass.find(object_id).to_menu_item[:title]
    end

    def description
      override = super
      return override if override.present?

      object_klass.find(object_id).to_menu_item[:description]
    end

    def url
      override = super
      return override if override.present?

      object_klass.find(object_id).to_menu_item[:url]
    end

    def object?
      true
    end

    # Calculate the object class associated to the menu item based on numeric value set within the modal
    # A numeric value is used rather than setting the actual class for security purposes
    def object_klass
      case object_type
      when 0
        Integral::Post
      end
    end
  end
end
