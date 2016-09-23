module Integral
  class Menu < ActiveRecord::Base
    # Associations
    has_many :menu_items

    # Validations
    validates :title, presence: true

    # Nested forms
    accepts_nested_attributes_for :menu_items, reject_if: :all_blank, allow_destroy: true
  end
end
