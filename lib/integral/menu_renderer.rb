module Integral
  class MenuRenderer
    include ActionView::Helpers::TagHelper
    include ActionView::Context

    attr_accessor :menu

    def self.render(menu)
      renderer = self.new(menu)
      renderer.render
    end

    def initialize(menu)
      @menu = menu
    end

    def render
      return render_no_menu_warning if @menu.nil?
      return render_no_items_warning if @menu.menu_items.empty?

      rendered_items = ''

      @menu.menu_items.each do |menu_item|
        rendered_items += render_item(menu_item)
      end

      content_tag 'ul', rendered_items, html_options, false
    end

    def render_no_menu_warning
      Rails.logger.error('IntegralError: Tried to render a menu with a nil argument.')
      '<!-- Warning: Tried to render a menu with a nil argument. -->'
    end

    def render_no_items_warning
      Rails.logger.error('IntegralError: Tried to render a menu with no items.')
      '<!-- Warning: Tried to render a menu with no items. -->'
    end

    private

    def html_options
      opts = {}
      opts[:id] = menu.html_id if menu.html_id.present?
      opts[:class] = menu.html_classes if menu.html_classes.present?

      opts
    end

    def render_item(item)
      MenuItemRenderer.render(item)
    end
  end
end

