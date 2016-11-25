module Integral
  # Renders dynamic pages
  class PagesController < Integral.configuration.frontend_parent_controller
    before_filter :find_page, only: [:show]

    # GET /{page.path}
    # Presents dynamic pages
    def show
      @meta_data = {
        page_title: @page.title,
        page_description: @page.description,
        # TODO: Allow users to link images to a Page
        open_graph:  {
        }
      }
    end

    private

    def find_page
      if current_user.present?
        @page = Integral::Page.find(params[:id]).decorate
      else
        @page = Integral::Page.published.find(params[:id]).decorate
      end

      @page.decorate
    end
  end
end
