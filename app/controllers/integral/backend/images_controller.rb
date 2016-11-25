module Integral
  module Backend
    # Images controller
    class ImagesController < BaseController
      before_filter :set_image, only: [:edit, :update, :destroy, :show]
      before_filter :authorize_with_klass
      before_filter :set_breadcrumbs

      # GET /
      # Lists all images
      def index
        respond_to do |format|
          format.html do
            @images = Image.all.order('created_at DESC')
            @image = Image.new
          end

          format.json do
            respond_to_record_selector(Integral::Image)
          end
        end
      end

      # GET /new
      # Image creation form
      def new
        add_breadcrumb I18n.t('integral.breadcrumbs.new'), :new_backend_img_path
        @image = Image.new
      end

      # POST /
      # Image creation
      def create
        @image = Image.new(image_params)

        if @image.save
          flash.now[:notice] = I18n.t('integral.backend.images.notification.creation_success')
          render status: :created, partial: 'card', locals: { image: @image, card_class: 'hide' }
        else
          flash.now[:error] = I18n.t('integral.backend.images.notification.creation_failure')
          render status: :unprocessable_entity, nothing: true
        end
      end

      # GET /:id/edit
      # Image edit form
      def edit
        add_breadcrumb I18n.t('integral.breadcrumbs.edit'), :edit_backend_img_path
      end

      # PUT /:id
      # Updating an image
      def update
        if @image.update(image_params)
          flash[:notice] = I18n.t('integral.backend.images.notification.edit_success')
          redirect_to backend_img_index_path
        else
          flash[:error] = I18n.t('integral.backend.images.notification.edit_failure')
          render 'edit'
        end
      end

      # DELETE /:id
      def destroy
        if @image.destroy
          flash[:notice] = I18n.t('integral.backend.images.notification.delete_success')
        else
          flash[:error] = I18n.t('integral.backend.images.notification.delete_failure')
        end

        redirect_to backend_img_index_path
      end

      private

      def authorize_with_klass
        authorize Image
      end

      def set_image
        @image = Image.find(params[:id])
      end

      def image_params
        params.require(:image).permit(:title, :description, :file)
      end

      def set_breadcrumbs
        add_breadcrumb I18n.t('integral.breadcrumbs.dashboard'), :backend_dashboard_path
        add_breadcrumb I18n.t('integral.breadcrumbs.images'), :backend_img_index_path
      end
    end
  end
end
