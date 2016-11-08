module Integral
  class ListRenderer
    include ActionView::Helpers::TagHelper
    include ActionView::Helpers::TextHelper
    include ActionView::Helpers::AssetTagHelper
    include ActionView::Context

    attr_accessor :list, :opts

    def self.render(list, opts={})
      renderer = self.new(list, opts)
      renderer.render_safely
    end

    def initialize(list, opts={})
      @opts = opts.reverse_merge({
        item_renderer: ListItemRenderer,
        item_renderer_opts: {},
        wrapper_element: 'ul'
      })

      @list = list
    end

    def render_safely
      return render_no_list_warning if list.nil?
      return render_no_items_warning if list.list_items.empty?

      render
    end

    def render
      rendered_items = ''

      list.list_items.each do |list_item|
        rendered_items += render_item(list_item)
      end

      content_tag opts[:wrapper_element], rendered_items, html_options, false
    end

    def render_no_list_warning
      Rails.logger.error('IntegralError: Tried to render a list with a nil argument.')
      '<!-- Warning: Tried to render a list with a nil argument. -->'
    end

    def render_no_items_warning
      Rails.logger.error('IntegralError: Tried to render a list with no items.')
      '<!-- Warning: Tried to render a list with no items. -->'
    end

    private

    def html_options
      opts = {}
      opts[:id] = list.html_id if list.html_id.present?
      opts[:class] = html_classes if html_classes.present?
      opts[:data] = self.opts[:data_attributes]

      opts
    end

    def render_item(item)
      opts[:item_renderer].render(item, opts[:item_renderer_opts])
    end

    def html_classes
      return list.html_classes unless opts[:html_classes].present?

      "#{list.html_classes} #{opts[:html_classes]}"
    end
  end
end

