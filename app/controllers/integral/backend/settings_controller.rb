module Integral
  module Backend
    # Settings management
    class SettingsController < ApplicationController
      before_filter :set_breadcrumbs

      # GET /
      # Lists all settings
      def index
      end

      # POST /
      # Update settings
      def create
        # Parse for booleans
        settings_params.each do | key, value |
          Settings[key] = parsed_value(value) if value.present?
        end
      end

      private

      def parsed_value(value)
        return true if value == '_1'
        return false if value == '_0'

        value
      end

      def settings_params
        params[:settings].permit(:website_title, :contact_email, :twitter_handler, :facebook_handler, :youtube_handler,
                                 :google_plus_handler, :linkedin_handler,
                                 :google_tracking_code
                                )
      end

      def set_breadcrumbs
        add_breadcrumb I18n.t('integral.breadcrumbs.dashboard'), :root_path
        add_breadcrumb I18n.t('integral.breadcrumbs.settings'), :backend_settings_path
      end
    end
  end
end
