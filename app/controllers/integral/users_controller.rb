require_dependency "integral/application_controller"

module Integral
  # Users controller
  class UsersController < ApplicationController
    before_filter :set_user, only: [:edit, :update, :destroy, :show]

    # before_filter :authorize_with_instance, only: [ :show, :edit, :update ]
    # before_filter :authorize_with_klass, only: [ :index, :new, :create, :destroy ]

    add_breadcrumb I18n.t('breadcrumbs.dashboard'), :root_path
    add_breadcrumb I18n.t('breadcrumbs.users'), :users_path

    # GET /
    # Lists all users
    def index
      @users_grid = initialize_grid(User)
    end

    # GET /new
    # User creation form
    def new
      add_breadcrumb I18n.t('breadcrumbs.new'), :new_user_path
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
        redirect_to user_path(@user)
      else
        render 'new'
      end
    end

    # GET /:id/edit
    # User edit form
    def edit
      add_breadcrumb @user.name, :user_path
      add_breadcrumb I18n.t('breadcrumbs.edit'), :edit_user_path
    end

    # PUT /:id
    # Updating a user
    def update
      authorized_user_params = user_params
      #authorized_user_params.delete(:role_ids) unless policy(@user).manager?

      if @user.update(authorized_user_params)
        redirect_to user_path(@user)
      else
        render 'edit'
      end
    end

    # DELETE /:id
    def destroy
      @user.destroy

      redirect_to users_path
    end

    private

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
