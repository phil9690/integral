Integral::Engine.routes.draw do
  devise_for :users, class_name: "Integral::User", module: :devise
end
