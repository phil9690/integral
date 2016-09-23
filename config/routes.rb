Integral::Engine.routes.draw do
  root 'static_pages#dashboard'

  # User Authentication
  devise_for :users, class_name: "Integral::User", module: :devise

  # User account Profile route
  get 'account', to: 'users#account'

  # WYSIWYG Editor
  mount Ckeditor::Engine => '/ckeditor'

  # User Management
  resources :users

  # Image Management
  resources :images, as: :img

  # Page Management
  resources :pages, except: [ :show ]

  # Menu Management
  resources :menus

  # Post Management
  resources :posts, except: [ :show ] do
    # resources :comments, only: [:create, :destroy]
  end
end
