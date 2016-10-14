module Integral
  class MenuItem < ActiveRecord::Base
    # Default scope orders by priority
    default_scope { order(:priority) }

    # Associations
    belongs_to :image
    has_and_belongs_to_many(:children,
                            join_table: "integral_menu_item_connections",
                            foreign_key: "parent_id",
                            association_foreign_key: "child_id",
                            class_name: 'MenuItem')

    # Nested forms
    accepts_nested_attributes_for :children, reject_if: :all_blank, allow_destroy: true

    # @return [Array] list of types available for a menu item
    def self.types_collection
      collection = [
        [I18n.t('integral.lists.items.type.basic'), 'Integral::Basic'],
        [I18n.t('integral.lists.items.type.link'), 'Integral::Link']
      ]

      self.listable_objects.each do |listable|
        collection << [listable.listable_options[:record_title], 'Integral::Object', { data: { object_type: listable.to_s, record_selector: listable.to_s.parameterize} }]
      end

      collection
    end

    # This should only be done on initialize really as it's never going to change
    def self.listable_objects
      listables =  []

      Integral.configuration.listable_objects.each do |listable|
        object = listable.constantize

        if object.method_defined?(:to_menu_item) && object.respond_to?(:listable_options)

          listables << object
        else
          Rails.logger.error("Removing listable '#{listable}' as it is missing required methods")
        end
      end

      listables
    end

    def object?
      false
    end

    def basic?
      false
    end

    def has_children?
      children.present?
    end
  end
end
