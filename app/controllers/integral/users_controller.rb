require_dependency "integral/application_controller"

module Integral
  # Users controller
  class UsersController < ApplicationController
    before_filter :set_user, only: [:edit, :update, :destroy, :show]

    before_filter :authorize_with_instance, only: [ :show, :edit, :update ]
    before_filter :authorize_with_klass, only: [ :index, :new, :create, :destroy ]

    add_breadcrumb I18n.t('integral.breadcrumbs.dashboard'), :root_path
    add_breadcrumb I18n.t('integral.breadcrumbs.users'), :users_path

    # GET /
    # Lists all users
    def index
      @users_grid = initialize_grid(User)
    end

    # GET /new
    # User creation form
    def new
      add_breadcrumb I18n.t('integral.breadcrumbs.new'), :new_user_path
      @user = User.new
    end

    # GET /:id
    # Show specific user
    #
    def show
      add_breadcrumb @user.name, :user_path
    end

    # POST /
    # User creation
    def create
      @user = User.new(user_params)

      if @user.save
        respond_successfully I18n.t('integral.users.notification.creation_success'), user_path(@user)
      else
        respond_failure I18n.t('integral.users.notification.creation_failure'), 'new'
      end
    end

    # GET /:id/edit
    # User edit form
    def edit
      add_breadcrumb @user.name, :user_path
      add_breadcrumb I18n.t('integral.breadcrumbs.edit'), :edit_user_path
    end

    # PUT /:id
    # Updating a user
    def update
      authorized_user_params = user_params
      authorized_user_params.delete(:role_ids) unless policy(@user).manager?

      if @user.update(authorized_user_params)
        respond_successfully I18n.t('integral.users.notification.edit_success'), user_path(@user)
      else
        respond_failure I18n.t('integral.users.notification.edit_failure'), 'edit'
      end
    end

    # DELETE /:id
    def destroy
      @user.destroy

      respond_successfully I18n.t('integral.users.notification.delete_success'), users_path
    end

    private

    def respond_successfully(flash_message, redirect_path)
      flash[:notice] = flash_message
      redirect_to redirect_path
    end

    def respond_failure(flash_message, template)
      flash.now[:error] = flash_message
      render template
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      return params.require(:user).permit(:name, :email, :avatar, role_ids: [] ) unless params[:user][:password].present?

      params.require(:user).permit(:name, :email, :avatar, :password, :password_confirmation, role_ids: [])
    end

    def authorize_with_klass
      authorize User
    end

    def authorize_with_instance
      authorize @user
    end
  end
end
