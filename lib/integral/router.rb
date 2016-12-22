module Integral
  # Handles Integral routing
  class Router
    # Loads Integral routes
    def self.load
      draw_root
      draw_frontend
      draw_backend
    end

    # Draws root route
    def self.draw_root
      Integral::Engine.routes.draw do
        root 'static_pages#home'
      end
    end

    # Draws frontend routes including dynamic pages and blog routes
    def self.draw_frontend
      Integral::Engine.routes.draw do
        # Dynamic pages
        Integral::PageRouter.load

        # Frontend Blog routes
        if Integral.configuration.blog_enabled
          scope Integral.configuration.blog_namespace do
            resources :tags, only: [:index, :show]
          end
          # Post Routing must go after tags otherwise it will override
          resources Integral.configuration.blog_namespace, only: [ :show, :index ], as: :posts, controller: 'posts'
        end
      end
    end

    # Draws backend routes
    def self.draw_backend
      Integral::Engine.routes.draw do
        # Backend [User Only]
        scope Integral.configuration.backend_namespace do
          # User Authentication
          devise_for :users, class_name: "Integral::User", module: :devise

          # WYSIWYG Editor
          mount Ckeditor::Engine => '/ckeditor'
        end

        namespace :backend, path: Integral.configuration.backend_namespace do
          get '/', to: 'static_pages#dashboard', as: 'dashboard'

          # User account Profile route
          get 'account', to: 'users#account'

          # User Management
          resources :users

          # Image Management
          resources :images, as: :img

          # Page Management
          resources :pages, except: [ :show ]

          # Post Management
          if Integral.configuration.blog_enabled
            resources :posts, except: [ :show ] do
              # resources :comments, only: [:create, :destroy]
            end
          end

          # List Management
          resources :lists

          # Settings Management
          resources :settings, only: [:index, :create]
        end

      end
    end
  end
end
