module Integral
  # Handles dynamic page routing.
  # Adapted from the below tutorial
  # http://codeconnoisseur.org/ramblings/creating-dynamic-routes-at-runtime-in-rails-4
  #
  # Note: Currently a server restart is required when creating pages using Heroku for the routes to show up.
  class PageRouter
    # Adds dynamic page routes
    def self.load
      # Allows tasks like assets:precompile to take place without the database setup
      return unless database_is_ready?

      # TODO: Make this code more robust to handle any exceptions occurring when creating paths.
      # For instance // is currently a valid path but would cause this code to blow up and not properly create the routes.
      Integral::Engine.routes.draw do
        Integral::Page.all.each do |page|
          get "/#{page.path}", controller: "pages", action: "show", id: page.id
        end
      end
    end

    # Force reload the application routes
    def self.reload
      Rails.application.reload_routes!
    end

    private

    def self.database_is_ready?
      table_exists = ActiveRecord::Base.connection.table_exists?('integral_pages') ? true : false
      # Enable 'DISABLE_ROUTER' when carrying out modifications on the Users table
      disable_router = ENV['DISABLE_ROUTER']

      if table_exists && disable_router != 'true'
        Rails.logger.info "Dynamic Page Router Enabled"
        true
      else
        Rails.logger.info "Dynamic Page Router Disabled"
        false
      end
    rescue ActiveRecord::NoDatabaseError
      Rails.logger.info "Dynamic Page Router Disabled"
      false
    end
  end
end
