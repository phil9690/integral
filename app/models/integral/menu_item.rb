module Integral
  class MenuItem < ActiveRecord::Base
    # Associations
    has_and_belongs_to_many(:children,
                            :join_table => "integral_menu_item_connections",
                            :foreign_key => "parent_id",
                            :association_foreign_key => "child_id",
                            :class_name => 'MenuItem')

    # Nested forms
    accepts_nested_attributes_for :children, reject_if: :all_blank, allow_destroy: true

    # Validations
    validates :title, :url, presence: true
  end
end
