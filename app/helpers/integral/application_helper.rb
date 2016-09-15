module Integral
  # Base helper inherited from all Integral helpers
  module ApplicationHelper

    # Creates an anchor link
    #
    # @param body [String] body of the link
    # @param location [String] location of the anchor
    #
    # @return [String] anchor to a particular location of the current page
    def anchor_to(body, location)
      current_path = url_for(:only_path => false)
      path = "#{current_path}##{location}"

      link_to body, path
    end

    # @return [String] markup listing flashes
    def render_flashes
      flash_types = [:notice, :alert, :error]

      content_tag :div, id: :flash_list do
        flash_types.each do |type|
          concat render_flash(type, flash[type]) if flash[type].present?
        end
      end
    end

    def boolean_select_options
      [
        [I18n.t('integral.boolean.true'), 'true'],
        [I18n.t('integral.boolean.false'), 'false']
      ]
    end

    # Renders icon link
    #
    # @param [String] icon to use
    # @param [String] url to link to
    # @param [Hash] html_options to pass through to link_to helper
    #
    # @return [String] twitter url
    def icon_link_to(icon, url, html_options={})
      icon_classes = html_options.delete(:icon_classes)
      icon_text = html_options.delete(:text)

      icon_classes = 'left' if icon_classes.blank?
      link_to "<i class='material-icons #{icon_classes}'>#{icon}</i>#{icon_text}".html_safe, url, html_options
    end

    private

    def render_flash(type, message)
      content_tag(:div, nil, class: :flash, data: { message: message, klass: type })
    end
  end
end
