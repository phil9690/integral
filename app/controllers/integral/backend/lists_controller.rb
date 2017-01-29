module Integral
  module Backend
    # List controller
    class ListsController < BaseController
      before_filter :set_list, only: [:edit, :update, :destroy, :show, :clone]
      before_filter :authorize_with_klass
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

        add_breadcrumb @list.title, :backend_list_path
      end

      # GET /new
      # List creation form
      def new
        add_breadcrumb I18n.t('integral.breadcrumbs.new'), :new_backend_list_path
        @list = List.new
      end

      # POST /
      # List creation
      def create
        @list = List.new(list_params)

        if @list.save
          respond_successfully(I18n.t('integral.backend.lists.notification.creation_success'), backend_list_path(@list))
        else
          respond_failure(I18n.t('integral.backend.lists.notification.creation_failure'), :new)
        end
      end

      # GET /:id/edit
      # List edit form
      def edit
        add_breadcrumb I18n.t('integral.breadcrumbs.edit'), :edit_list_path
      end

      # GET /:id/clone
      # Clone a list
      def clone
        title = params[:title].present? ? params[:title] : "#{@list.title} Copy"
        title = "#{title} #{SecureRandom.hex[1..5]}"if Integral::List.find_by_title(title).present?

        cloned_list = @list.dup(title)

        if cloned_list.save
          respond_successfully(I18n.t('integral.backend.lists.notification.creation_success'), backend_list_path(cloned_list))
        else
          respond_failure(I18n.t('integral.backend.lists.notification.creation_failure'), :show)
        end
      end

      # PUT /:id
      # Updating an list
      def update
        if @list.update(list_params)
          respond_successfully(I18n.t('integral.backend.lists.notification.edit_success'), backend_list_path(@list))
        else
          respond_failure(I18n.t('integral.backend.lists.notification.edit_failure'), :show)
        end
      end

      # DELETE /:id
      def destroy
        if @list.destroy
          respond_successfully(I18n.t('integral.backend.lists.notification.delete_success'), backend_lists_path)
        else
          error_message = @list.errors.full_messages.to_sentence
          flash[:error] = "#{I18n.t('integral.backend.lists.notification.delete_failure')} - #{error_message}"
          redirect_to backend_lists_path
        end
      end

      private

      def authorize_with_klass
        authorize List
      end

      def set_list
        @list = List.find(params[:id])
      end

      # TODO: Can this be tidied up?
      def list_params
        params.require(:list).permit(:title, :description, :html_id, :html_classes,
          list_items_attributes: [
                                  :id, :type, :object_type, :object_id,  :title, :subtitle, :url, :image_id, :target,
                                  :priority, :_destroy, :description, :html_classes,
                                  children_attributes: list_item_attributes
                                 ])
      end

      def list_item_attributes
        [
          :id, :type, :object_type, :object_id, :title, :url, :image_id,
          :target, :priority, :description, :subtitle, :html_classes, :_destroy
        ]
      end

      def set_breadcrumbs
        add_breadcrumb I18n.t('integral.breadcrumbs.dashboard'), :backend_dashboard_path
        add_breadcrumb I18n.t('integral.breadcrumbs.lists'), :backend_lists_path
      end
    end
  end
end
