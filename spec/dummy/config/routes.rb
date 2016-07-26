Rails.application.routes.draw do
  mount Integral::Engine => "/admin"

  root 'static_pages#welcome'
end
