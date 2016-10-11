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
      return render_empty_menu if @menu.menu_items.empty?

      rendered_items = ''

      @menu.menu_items.each do |menu_item|
        rendered_items += render_item(menu_item)
      end

      content_tag 'ul', rendered_items, html_options, false
    end

    def render_empty_menu
      # TODO: This should be a HTML comment
      'Menu does not contain any items!'
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

