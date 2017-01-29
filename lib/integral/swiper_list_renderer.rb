module Integral
  # Swiper list renderer - Renders list items within swiper container
  class SwiperListRenderer < Integral::ListRenderer
    # Override Integral::ListRenderer#render to wrap swiper-container around all rendered_items
    def render
      rendered_items = ''
      list_items = list.list_items.to_a

      list_items.each do |list_item|
        rendered_items += render_item(list_item)
      end

      rendered_items = "<div class='swiper-container section-swiper'><div class='swiper-wrapper'>'#{rendered_items}</div><div class='swiper-pagination'></div></div>"

      content_tag opts[:wrapper_element], rendered_items, html_options, false
    end
  end
end
