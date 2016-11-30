module Integral
  # Represents a generic list such as a gallery or menu
  class List < ActiveRecord::Base
    # Associations
    has_many :list_items

    # Validations
    validates :title, presence: true

    before_destroy :validate_unlocked

    # Nested forms
    accepts_nested_attributes_for :list_items, reject_if: :all_blank, allow_destroy: true

    private

    def validate_unlocked
      return unless locked?

      errors.add(:locked, "Cannot delete a locked item")
      false
    end
  end
end
