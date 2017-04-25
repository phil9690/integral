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

    # Checks if dynamic page routing should be enabled
    # If there is any issue connecting to the database or if integral_pages table does not exist we return false
    def self.database_is_ready?
      table_exists = ActiveRecord::Base.connection.table_exists?('integral_pages') ? true : false
      # TODO: Change this to configuration variable
      disable_router = ENV['DISABLE_ROUTER']

      if table_exists && disable_router != 'true'
        Rails.logger.info "Integral: Dynamic Page Router Enabled"
        true
      else
        Rails.logger.info "Integral: Dynamic Page Routing Disabled"
        false
      end
    rescue => error
      Rails.logger.info "Integral: Dynamic Page Routing Disabled [Error connecting to DB]"
      false
    end
  end
end
