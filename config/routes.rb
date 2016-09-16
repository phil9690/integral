Integral::Engine.routes.draw do
  root 'static_pages#dashboard'

  # Dynamic pages
  Integral::PageRouter.load

  # TODO: Frontend Blog routes

  # Backend [User Only]
  #
  # TODO: Set path as configurable variable
  scope 'admin' do
    # User Authentication
    devise_for :users, class_name: "Integral::User", module: :devise

    # WYSIWYG Editor
    mount Ckeditor::Engine => '/ckeditor'
  end

  namespace :backend, path: 'admin' do
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
  end
end
