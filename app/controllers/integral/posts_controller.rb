module Integral
  # Post management
  class PostsController < ApplicationController
    before_filter :set_post, only: [:edit, :update, :destroy, :show]
    before_filter :set_breadcrumbs

    # GET /
    # Lists all posts
    def index
      respond_to do |format|
        format.html do
          grid_options = {
            order: 'integral_posts.updated_at',
            order_direction: 'desc'
          }

          @posts_grid = initialize_grid(Post, grid_options)

          @published_posts_count = Integral::Post.published.count
          @draft_posts_count = Integral::Post.draft.count
        end

        format.json do
          @posts = Integral::Post.all.paginate(:page => params[:page])
          sleep 1
          render json: { content: render_to_string(partial: 'integral/shared/record_selector/collection', locals: { collection: @posts }) }
        end
      end
    end

    # GET /new
    # Post creation form
    def new
      add_breadcrumb I18n.t('integral.breadcrumbs.new'), :new_post_path
      @post = Post.new
    end

    # POST /
    # Post creation
    def create
      @post = Post.new(post_params)
      @post.user = current_user

      if @post.save
        flash[:notice] = I18n.t('integral.posts.notification.creation_success')
        redirect_to edit_post_path(@post)
      else
        flash[:error] = I18n.t('integral.posts.notification.creation_failure')
        render 'new'
      end
    end

    # GET /:id/edit
    # Post edit form
    def edit
      add_breadcrumb I18n.t('integral.breadcrumbs.edit'), :edit_post_path
    end

    # PUT /:id
    # Updating a post
    def update
      if @post.update(post_params)
        flash[:notice] = I18n.t('integral.posts.notification.edit_success')
        redirect_to edit_post_path(@post)
      else
        flash[:error] = I18n.t('integral.posts.notification.edit_failure')
        render 'edit'
      end
    end

    # DELETE /:id
    def destroy
      if @post.destroy
        flash[:notice] = I18n.t('integral.posts.notification.delete_success')
      else
        flash[:error] = I18n.t('integral.posts.notification.delete_failure')
      end

      redirect_to posts_path
    end

    private

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :slug, :body, :description, :tag_list, :image, :status)
    end

    def set_breadcrumbs
      add_breadcrumb I18n.t('integral.breadcrumbs.dashboard'), :root_path
      add_breadcrumb I18n.t('integral.breadcrumbs.posts'), :posts_path
    end
  end
end
