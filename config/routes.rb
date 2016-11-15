Integral::Engine.routes.draw do
  root 'static_pages#dashboard'

  # Dynamic pages
  Integral::PageRouter.load

  # Frontend Blog routes
  scope Integral.configuration.blog_namespace do
    resources :tags, only: [:index, :show]
  end
  # Post Routing must go after tags otherwise it will override
  resources Integral.configuration.blog_namespace, only: [ :show, :index ], as: :posts, to: 'posts'

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
    resources :posts, except: [ :show ] do
      # resources :comments, only: [:create, :destroy]
    end

    # List Management
    resources :lists

    # Settings Management
    resources :settings, only: [:index, :create]
  end
end
