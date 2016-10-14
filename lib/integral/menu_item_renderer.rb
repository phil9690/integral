module Integral
  class MenuItemRenderer
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::TextHelper
    include ActionView::Context

    attr_accessor :menu_item

    def self.render(menu_item)
      renderer = self.new(menu_item)
      renderer.render
    end

    def initialize(menu_item)
      @menu_item = menu_item
    end

    def render
      content_tag :li, class: menu_item.html_classes do
        if menu_item.has_children?
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
      opts[:class] = 'dropdown-button' if menu_item.has_children?
      opts[:href] = url if url.present?
      opts[:target] = target if target.present?

      opts
    end

    def render_children
      children = ''

      menu_item.children.each do |child|
        children += self.class.render(child)
      end

      children
    end

    def type_for_dropdown
      menu_item.type if !menu_item.object?
      menu_item.object_type.to_s
    end

    def title
      provide_attr(:title)
    end

    def description
      provide_attr(:description)
    end

    def target
      menu_item.target if !menu_item.basic?
    end

    def url
      provide_attr(:url) if !menu_item.basic?
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
      menu_item_attr_value = menu_item.public_send(attr)
      return menu_item_attr_value if !menu_item.object? || menu_item_attr_value.present?

      object_data[attr]
    end

    def object_data
      @object_data ||= menu_item.object_klass.find(menu_item.object_id).to_menu_item
    end
  end
end

