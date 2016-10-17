module Integral
  # List controller
  class ListsController < ApplicationController
    before_filter :set_list, only: [:edit, :update, :destroy, :show]
    before_filter :authorize_with_klass, only: [ :index, :new, :create, :edit, :update, :destroy ]
    before_filter :set_breadcrumbs

    # GET /
    # Lists all lists
    def index
      @lists_grid = initialize_grid(List)
    end

    # GET /:id
    def show
      @list = List.find(params[:id])
      @list.list_items.order(:priority)

      add_breadcrumb @list.title, :list_path
    end

    # GET /new
    # List creation form
    def new
      add_breadcrumb I18n.t('integral.breadcrumbs.new'), :new_list_path
      @list = List.new
    end

    # POST /
    # List creation
    def create
      @list = List.new(list_params)

      if @list.save
        flash.now[:notice] = I18n.t('integral.lists.notification.creation_success')
        redirect_to @list
      else
        flash.now[:error] = I18n.t('integral.lists.notification.creation_failure')
        render :new
      end
    end

    # GET /:id/edit
    # List edit form
    def edit
      add_breadcrumb I18n.t('integral.breadcrumbs.edit'), :edit_list_path
    end

    # PUT /:id
    # Updating an list
    def update
      if @list.update(list_params)
        flash[:notice] = I18n.t('integral.lists.notification.edit_success')
        redirect_to list_path
      else
        flash[:error] = I18n.t('integral.lists.notification.edit_failure')
        render 'show'
      end
    end

    # DELETE /:id
    def destroy
      if @list.destroy
        flash[:notice] = I18n.t('integral.lists.notification.delete_success')
      else
        error_message = @list.errors.full_messages.to_sentence
        flash[:error] = "#{I18n.t('integral.lists.notification.delete_failure')} - #{error_message}"
      end

      redirect_to lists_path
    end

    private

    def authorize_with_klass
      authorize List
    end

    def set_list
      @list = List.find(params[:id])
    end

    def list_params
      params.require(:list).permit(:title, :description, :html_id, :html_classes, list_items_attributes: [:id, :type, :object_type, :object_id,  :title, :url, :image_id, :target, :priority, :_destroy, :description, :html_classes, children_attributes: [:id, :type, :object_type, :object_id, :title, :url, :image_id, :target, :priority, :description, :html_classes, :_destroy]])
    end

    def set_breadcrumbs
      add_breadcrumb I18n.t('integral.breadcrumbs.dashboard'), :root_path
      add_breadcrumb I18n.t('integral.breadcrumbs.lists'), :lists_path
    end
  end
end
