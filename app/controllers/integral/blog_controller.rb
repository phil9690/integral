module Integral
  # Blog controller
  class BlogController < Integral.configuration.frontend_parent_controller.constantize
    before_filter :set_side_bar_data
    before_filter :add_breadcrumbs

    private

    def set_side_bar_data
      load_recent_posts
      load_popular_posts
      @popular_tags = Integral::Post.tag_counts_on(I18n.locale, order: 'count desc', limit: 5)
    end

    def add_breadcrumbs
      add_breadcrumb I18n.t('integral.breadcrumbs.home'), :root_url
      add_breadcrumb I18n.t('integral.breadcrumbs.blog'), :posts_url
    end
  end
end
