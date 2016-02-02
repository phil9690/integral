module Integral
  # Base helper inherited from all Integral helpers
  module ApplicationHelper

    # @return [String] markup listing flashes
    def render_flashes
      flash_types = [:notice, :alert, :error]

      content_tag :div, id: :flash_list do
        flash_types.each do |type|
          concat render_flash(type, flash[type]) if flash[type].present?
        end
      end
    end

    private

    def render_flash(type, message)
      content_tag(:div, nil, class: :flash, data: { message: message, klass: type })
    end
  end
end
