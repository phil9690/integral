Integral::Engine.routes.draw do
  root 'static_pages#dashboard'

  # User Authentication
  devise_for :users, class_name: "Integral::User", module: :devise

  # WYSIWYG Editor
  mount Ckeditor::Engine => '/ckeditor'

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
