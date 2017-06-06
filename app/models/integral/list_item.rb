module Integral
  # Represents an item within a particular list
  class ListItem < ActiveRecord::Base
    after_initialize :set_defaults
    before_save :touch_list
    after_touch :touch_list

    # Default scope orders by priority and includes children
    default_scope { includes(:children).includes(:image).order(:priority) }

    # Associations
    belongs_to :list
    belongs_to :image
    has_and_belongs_to_many(:children,
                            join_table: "integral_list_item_connections",
                            foreign_key: "parent_id",
                            association_foreign_key: "child_id",
                            class_name: 'ListItem',
                            after_add: :touch_updated_at,
                            after_remove: :touch_updated_at)

    # Nested forms
    accepts_nested_attributes_for :children, reject_if: :all_blank, allow_destroy: true

    # @return [Array] list of types available for a list item
    def self.types_collection
      collection = [
        [I18n.t('integral.backend.lists.items.type.basic'), 'Integral::Basic', data: { true_value: 'Integral::Basic' }],
        [I18n.t('integral.backend.lists.items.type.link'), 'Integral::Link', data: {true_value: 'Integral::Link' }]
      ]

      ActsAsListable.objects.each do |listable|
        collection << [listable.listable_options[:record_title], listable.to_s, data: { object_type: listable.to_s, record_selector: listable.to_s.parameterize, true_value: 'Integral::Object' }]
      end

      collection
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

    private

    def set_defaults
      self.type ||= 'Integral::Basic'
    end

    def touch_updated_at(list_item)
      self.touch if persisted?
    end

    def touch_list
      list.touch if list.present?
    end
  end
end
