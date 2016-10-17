module Integral
  class ListItemRenderer
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::TextHelper
    include ActionView::Context

    attr_accessor :list_item

    def self.render(list_item)
      renderer = self.new(list_item)
      renderer.render
    end

    def initialize(list_item)
      @list_item = list_item
    end

    def render
      content_tag :li, class: list_item.html_classes do
        if list_item.has_children?
          concat render_item
          concat content_tag :ul, render_children, { class: 'dropdown-content' }, false
        else
          render_item
        end
      end
    end

    def render_item
      content_tag :a, title, item_options
    end

    def item_options
      opts = {}
      opts[:class] = 'dropdown-button' if list_item.has_children?
      opts[:href] = url if url.present?
      opts[:target] = target if target.present?

      opts
    end

    def render_children
      children = ''

      list_item.children.each do |child|
        children += self.class.render(child)
      end

      children
    end

    def type_for_dropdown
      return list_item.type if !list_item.object?
      list_item.object_type.to_s
    end

    def title
      provide_attr(:title)
    end

    def description
      provide_attr(:description)
    end

    def target
      list_item.target if !list_item.basic?
    end

    def url
      provide_attr(:url) if !list_item.basic?
    end

    def subtitle
      provide_attr(:subtitle)
    end

    def image
      provide_attr(:image)
    end

    def has_children?
      children.present?
    end

    private

    # Works out what the provided attr evaluates to.
    #
    # @param attr [Symbol] attribute to evaluate
    #
    # @return [String] value of attribute
    def provide_attr(attr)
      list_item_attr_value = list_item.public_send(attr)
      return list_item_attr_value if !list_item.object? || list_item_attr_value.present?

      object_data[attr]
    end

    def object_data
      @object_data ||= list_item.object_klass.find(list_item.object_id).to_list_item
    end
  end
end

