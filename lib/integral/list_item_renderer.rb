module Integral
  # Handles safely rendering list items
  class ListItemRenderer
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::TextHelper
    include ActionView::Helpers::AssetTagHelper
    include ActionView::Context

    attr_accessor :list_item, :opts

    # Renders the provided list item with options given
    #
    # @return [String] the rendered list item
    def self.render(list_item, opts={})
      renderer = self.new(list_item, opts)
      renderer.render
    end

    # @param list_item [ListItem] object to render
    # @param opts [Hash] options hash
    def initialize(list_item, opts={})
      @opts = opts.reverse_merge({
        wrapper_element: 'li',
        child_wrapper_element: 'ul'
      })

      @list_item = list_item
    end

    # Renders the provided list_item
    #
    # @return [String] the rendered list item (including possible children)
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

    # @return [String] list item HTML
    def render_item
      content_tag :a, title, item_options
    end

    # @return [Hash] list item options
    def item_options
      opts = {}
      opts[:class] = 'dropdown-button' if list_item.has_children?
      opts[:href] = url if url.present?
      opts[:target] = target if target.present?

      opts
    end

    # Loop over all list item children calling render on each
    #
    # @return [String] compiled string of all the rendered list item children
    def render_children
      children = ''

      list_item.children.each do |child|
        children += self.class.render(child, opts)
      end

      children
    end

    # Used within backend for preselecting type in dropdown
    # TODO: Move this onto the model level
    def type_for_dropdown
      return list_item.type if !list_item.object?
      list_item.object_type.to_s
    end

    # @return [String] title of list item
    def title
      provide_attr(:title)
    end

    # @return [String] description of list item
    def description
      provide_attr(:description)
    end

    # @return [String] target of list item
    def target
      list_item.target if !list_item.basic?
    end

    # @return [String] URL of list item
    def url
      provide_attr(:url) if !list_item.basic?
    end

    # @return [String] subtitle of list item
    def subtitle
      provide_attr(:subtitle)
    end

    # Returns the non object image path
    def object_image
      image = object_data[:image] if object_available?

      return image.file.url if image.respond_to?(:file)
      return image if image.present?

      fallback_image
    end

    # @return [Boolean] whether or not list item has an image linked to it (which isn't through an object)
    def has_non_object_image?
      list_item.image.present?
    end

    # Returns the non object image path
    def non_object_image
      image = list_item.image

      return image.file.url if image.respond_to?(:file)
      return image if image.present?

      fallback_image
    end

    # Returns the image path rather than an actual Integral::Image object
    def image
      image = provide_attr(:image)

      return image.file.url if image.respond_to?(:file)
      return image if image.present?

      fallback_image
    end

    # @return [Boolean] whether or not title is a required attribute
    # TODO: This and other methods which are only used in backend could be moved to decorators
    def title_required?
      !list_item.object?
    end

    # @return [String] path to fallback image for list items
    def fallback_image
      ActionController::Base.helpers.image_path('integral/defaults/no_image_available.jpg')
    end

    private

    def render_no_object_warning
      Rails.logger.error('IntegralError: Tried to render a list item with no object.')
      '<!-- Warning: Tried to render a list item with no object. -->'
    end

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

