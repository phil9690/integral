Integral::Engine.routes.draw do
  root 'static_pages#dashboard'

  devise_for :users, class_name: "Integral::User", module: :devise
end
