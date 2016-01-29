Rails.application.routes.draw do
  mount Integral::Engine => "/admin"
end
