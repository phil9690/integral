module Integral
  # Base controller inherited by all Integral controllers
  class ApplicationController < ActionController::Base
    # User authentication
    before_action :authenticate_user!

    before_action :set_locale

    # User authorization
    include Pundit
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    layout :layout_by_resource

    private

    def respond_to_record_selector(klass)
      records = klass.search(params[:search]).paginate(page: params[:page])
      render json: { content: render_to_string(partial: 'integral/shared/record_selector/collection', locals: { collection: records }) }
    end

    # Redirect user to integral.root_path after successful login
    def after_sign_in_path_for(resource)
      integral.root_path
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
        "integral/application"
      end
    end

    def set_locale
      I18n.locale = current_user.locale if current_user.present?
    end
  end
end
