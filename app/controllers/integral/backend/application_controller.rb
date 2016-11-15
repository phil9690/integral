module Integral
  # Backend module [Users only area]
  module Backend
    # Base controller for backend inherited by all Integral backend controllers
    class ApplicationController < ActionController::Base
      layout 'integral/backend'

      # User authentication
      before_action :authenticate_user!

      # User custom locale
      before_action :set_locale

      # User authorization
      include Pundit
      rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

      layout :layout_by_resource

      private

      # Redirect user to integral.root_path after successful login
      def after_sign_in_path_for(resource)
        backend_dashboard_path
      end

      def user_not_authorized
        flash[:alert] = I18n.t('errors.unauthorized')
        redirect_to(root_path)
      end

      # Handle custom devise layouts
      # https://github.com/plataformatec/devise/wiki/How-To:-Create-custom-layouts
      # Can't do it pretty way as have no access to Application.rb within Engine (?)
      def layout_by_resource
        if devise_controller?
          "integral/login"
        else
          "integral/backend"
        end
      end

      def set_locale
        I18n.locale = current_user.locale if current_user.present?
      end

      def respond_to_record_selector(klass)
        records = klass.search(params[:search]).paginate(page: params[:page])
        render json: { content: render_to_string(partial: 'integral/shared/record_selector/collection', locals: { collection: records }) }
      end
    end
  end
end
