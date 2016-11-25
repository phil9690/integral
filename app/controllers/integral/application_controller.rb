module Integral
  # Base Frontend controller
  class ApplicationController < ActionController::Base
    layout 'integral/frontend'

    # Search Engine Optimization
    before_render :load_meta_tags

    private

    def load_meta_tags
      meta_data = set_meta_data

      meta_options = {
        site: meta_data[:site_title],
        title: meta_data[:page_title],
        reverse: root_path != request.path,
        description: meta_data[:page_description],
        icon: '/favicon.ico',
        alternate: meta_data[:alternative],
        canonical: meta_data[:canonical],
        og: meta_data[:open_graph],
        twitter: meta_data[:twitter_card],
        fb: meta_data[:facebook]
      }

      set_meta_tags meta_options
      set_meta_tags og: { title: self.meta_tags.full_title }
    end

    def set_meta_data
      canonical_url = "#{Integral.configuration.website_url}#{request.path}"

      meta_data = @meta_data.blank? ? {} : @meta_data
      meta_data[:open_graph] = {} if meta_data[:open_graph].blank?
      meta_data[:site_title] ||= Integral.configuration.site_title
      meta_data[:page_title] ||= t('.title')
      meta_data[:page_description] ||= t('.description')
      meta_data[:canonical] ||= canonical_url

      open_graph_defaults = {
        title: meta_data[:page_title],
        description: meta_data[:page_description],
        image: view_context.image_url('previews/default.jpg'),
        type: 'website',
        site_name: meta_data[:site_title],
        url: canonical_url
      }

      meta_data[:open_graph].reject!{ |k,v| v.nil? }
      meta_data[:open_graph] = open_graph_defaults.merge!(meta_data[:open_graph])

      meta_data[:twitter_card] = {
        card: 'summary_large_image',
        site: Integral.configuration.twitter_handler,
        title: meta_data[:open_graph][:title],
        description: meta_data[:open_graph][:description],
        image: meta_data[:open_graph][:image]
      }

      meta_data[:facebook] = {
        app_id: Integral.configuration.facebook_app_id
      }

      meta_data
    end

    def load_recent_posts
      @recent_posts = Integral::Post.published.order("published_at DESC").limit(4)
    end

    def load_popular_posts
      @popular_posts = Integral::Post.published.order("view_count DESC").limit(4)
    end

    # Raises 404 if no user is logged in
    def verify_user
      raise ActionController::RoutingError.new('Not Found') if current_user.blank?
    end
  end
end
