module Integral
  class ListItemRenderer
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::TextHelper
    include ActionView::Helpers::AssetTagHelper
    include ActionView::Context

    attr_accessor :list_item, :opts

    def self.render(list_item, opts={})
      renderer = self.new(list_item, opts)
      renderer.render
    end

    def initialize(list_item, opts={})
      @opts = opts.reverse_merge({
        wrapper_element: 'li',
        child_wrapper_element: 'ul'
      })

      @list_item = list_item
    end

    def render
      return render_no_object_warning if list_item.object? && !object_available?

      content_tag opts[:wrapper_element], class: html_classes do
        if list_item.has_children?
          concat render_item
          concat content_tag opts[:child_wrapper_element], render_children, { class: 'dropdown-content' }, false
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
        children += self.class.render(child, opts)
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

    # Returns the image path rather than an actual Integral::Image object
    def image
      image = provide_attr(:image)

      return image.file.url if image.respond_to?(:file)
      return image if image.present?

      ActionController::Base.helpers.image_path('integral/defaults/no_image_available.jpg')
    end

    def title_required?
      !list_item.object?
    end

    def render_no_object_warning
      Rails.logger.error('IntegralError: Tried to render a list item with no object.')
      '<!-- Warning: Tried to render a list item with no object. -->'
    end

    private

    # Works out what the provided attr evaluates to.
    #
    # @param attr [Symbol] attribute to evaluate
    #
    # @return [String] value of attribute
    def provide_attr(attr)
      list_item_attr_value = list_item.public_send(attr)

      return list_item_attr_value if list_item_attr_value.present?

      return object_data[attr] if object_available?
      return 'Object Unavailable' if list_item.object? && !object_available?
      ''
    end

    def object_data
      @object_data ||= list_item.object_klass.find(list_item.object_id).to_list_item
    end

    def object_available?
      return false unless list_item.object?

      list_item.object_klass.exists?(list_item.object_id)
    end

    def html_classes
      return list_item.html_classes unless opts[:html_classes].present?

      "#{list_item.html_classes} #{opts[:html_classes]}"
    end
  end
end

