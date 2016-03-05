Integral::Engine.routes.draw do
  root 'static_pages#dashboard'

  # User Authentication
  devise_for :users, class_name: "Integral::User", module: :devise

  resources :users
  resources :images, as: :img
end
