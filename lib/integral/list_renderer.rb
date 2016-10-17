module Integral
  class ListRenderer
    include ActionView::Helpers::TagHelper
    include ActionView::Context

    attr_accessor :list

    def self.render(list)
      renderer = self.new(list)
      renderer.render
    end

    def initialize(list)
      @list = list
    end

    def render
      return render_no_list_warning if @list.nil?
      return render_no_items_warning if @list.list_items.empty?

      rendered_items = ''

      @list.list_items.each do |list_item|
        rendered_items += render_item(list_item)
      end

      content_tag 'ul', rendered_items, html_options, false
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
      opts[:class] = list.html_classes if list.html_classes.present?

      opts
    end

    def render_item(item)
      ListItemRenderer.render(item)
    end
  end
end

