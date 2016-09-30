module Integral
  # Menu controller
  class MenusController < ApplicationController
    before_filter :set_menu, only: [:edit, :update, :destroy, :show]
    before_filter :authorize_with_klass, only: [ :index, :new, :create, :edit, :update, :destroy ]
    before_filter :set_breadcrumbs

    # GET /
    # Lists all menus
    def index
      @menus_grid = initialize_grid(Menu)
    end

    # GET /:id
    def show
      @menu = Menu.find(params[:id])
      @menu.menu_items.order(:priority)

      add_breadcrumb @menu.title, :menu_path
    end

    # GET /new
    # Menu creation form
    def new
      add_breadcrumb I18n.t('integral.breadcrumbs.new'), :new_menu_path
      @menu = Menu.new
    end

    # POST /
    # Menu creation
    def create
      @menu = Menu.new(menu_params)

      if @menu.save
        flash.now[:notice] = I18n.t('integral.menus.notification.creation_success')
        redirect_to @menu
      else
        flash.now[:error] = I18n.t('integral.menus.notification.creation_failure')
        render :new
      end
    end

    # GET /:id/edit
    # Menu edit form
    def edit
      add_breadcrumb I18n.t('integral.breadcrumbs.edit'), :edit_menu_path
    end

    # PUT /:id
    # Updating an menu
    def update
      if @menu.update(menu_params)
        flash[:notice] = I18n.t('integral.menus.notification.edit_success')
        redirect_to menu_path
      else
        flash[:error] = I18n.t('integral.menus.notification.edit_failure')

        render 'edit'
      end
    end

    # DELETE /:id
    def destroy
      if @menu.destroy
        flash[:notice] = I18n.t('integral.menus.notification.delete_success')
      else
        error_message = @menu.errors.full_messages.to_sentence
        flash[:error] = "#{I18n.t('integral.menus.notification.delete_failure')} - #{error_message}"
      end

      redirect_to menus_path
    end

    private

    def authorize_with_klass
      authorize Menu
    end

    def set_menu
      @menu = Menu.find(params[:id])
    end

    def menu_params
      params.require(:menu).permit(:title, :description, menu_items_attributes: [:id, :type, :object_type, :object_id,  :title, :url, :image_id, :target, :priority, :_destroy, :description, :html_classes, children_attributes: [:id, :type, :object_type, :object_id, :title, :url, :image_id, :target, :priority, :description, :html_classes, :_destroy]])
    end

    def set_breadcrumbs
      add_breadcrumb I18n.t('integral.breadcrumbs.dashboard'), :root_path
      add_breadcrumb I18n.t('integral.breadcrumbs.menus'), :menus_path
    end
  end
end
