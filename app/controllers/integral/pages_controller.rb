module Integral
  # Pages controller
  class PagesController < ApplicationController
    before_filter :set_page, only: [:edit, :update, :destroy]
    before_filter :authorize_with_klass, only: [ :index, :new, :create, :edit, :update, :destroy ]
    before_filter :set_breadcrumbs

    # GET /
    # Lists all pages
    def index
      respond_to do |format|
        format.html do
          @pages_grid = initialize_grid(Page)

          @published_pages_count = Integral::Page.published.count
          @draft_pages_count = Integral::Page.draft.count
        end

        format.json do
          pages = Integral::Page.search(params[:search]).paginate(page: params[:page])
          render json: { content: render_to_string(partial: 'integral/shared/record_selector/collection', locals: { collection: pages }) }
        end
      end
    end

    # GET /new
    # Page creation form
    def new
      add_breadcrumb I18n.t('integral.breadcrumbs.new'), :new_page_path
      @page = Page.new
    end

    # POST /
    # Page creation
    def create
      @page = Page.new(page_params)

      if @page.save
        flash[:notice] = I18n.t('integral.pages.notification.creation_success')
        redirect_to edit_page_path(@page)
      else
        flash[:error] = I18n.t('integral.pages.notification.creation_failure')
        render 'new'
      end
    end

    # GET /:id/edit
    # Page edit form
    def edit
      add_breadcrumb I18n.t('integral.breadcrumbs.edit'), :edit_page_path
    end

    # PUT /:id
    # Updating an page
    def update
      if @page.update(page_params)
        flash[:notice] = I18n.t('integral.pages.notification.edit_success')
        redirect_to edit_page_path(@page)
      else
        flash[:error] = I18n.t('integral.pages.notification.edit_failure')
        render 'edit'
      end
    end

    # DELETE /:id
    def destroy
      if @page.destroy
        flash[:notice] = I18n.t('integral.pages.notification.delete_success')
      else
        error_message = @page.errors.full_messages.to_sentence
        flash[:error] = "#{I18n.t('integral.pages.notification.delete_failure')} - #{error_message}"
      end

      redirect_to pages_path
    end

    private

    def authorize_with_klass
      authorize Page
    end

    def set_page
      @page = Page.find(params[:id])
    end

    def page_params
      params.require(:page).permit(:title, :description, :path, :body, :status)
    end

    def set_breadcrumbs
      add_breadcrumb I18n.t('integral.breadcrumbs.dashboard'), :root_path
      add_breadcrumb I18n.t('integral.breadcrumbs.pages'), :pages_path
    end
  end
end
