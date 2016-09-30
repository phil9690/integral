module Integral
  class MenuItem < ActiveRecord::Base
    # Disable STI
    self.inheritance_column = :_type_disabled
    enum type: [ :basic, :link, :object ]

    # Default scope orders by priority
    default_scope { order(:priority) }

    # Associations
    belongs_to :image
    has_and_belongs_to_many(:children,
                            :join_table => "integral_menu_item_connections",
                            :foreign_key => "parent_id",
                            :association_foreign_key => "child_id",
                            :class_name => 'MenuItem')

    # Nested forms
    accepts_nested_attributes_for :children, reject_if: :all_blank, allow_destroy: true

    # Validations
    validates :title, :url, presence: true


    # @return [Array] list of types available for a menu item
    def self.types_collection
      [
        [I18n.t('integral.lists.items.type.basic'), :basic],
        [I18n.t('integral.lists.items.type.link'), :link],
        [I18n.t('integral.lists.items.type.post'), :object, { data: { object_type: 'Integral::Post' } }]
      ]
    end
  end
end
