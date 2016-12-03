module Integral
  # Front end tags controller
  class TagsController < BlogController
    before_filter :find_tag, only: [:show]

    # GET /
    # List blog tags
    def index
      @tags = Integral::Post.all_tag_counts(order: 'count desc').paginate(:page => params[:page])
    end

    # GET /:id
    # Presents blog tags
    def show
      add_breadcrumb @tag.name, :tag_url

      @meta_data = {
        page_title: @tag.name,
      }

      @tagged_posts = Integral::Post.tagged_with(@tag.name).published.paginate(:page => params[:page])
    end

    private

    def find_tag
      @tag = Integral::Post.all_tags.find_by_name!(params[:id])
    end

    def add_breadcrumbs
      super
      add_breadcrumb I18n.t('integral.breadcrumbs.tags'), :tags_url
    end
  end
end
