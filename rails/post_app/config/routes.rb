Rails.application.routes.draw do
  get 'static_pages/home'
  get 'static_pages/help'
  get 'static_pages/about'

  resources :microposts
  resources :users

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # app/controllers/application_controller.rb
  # path /
  # root 'application#hello'

  root 'users#index'
end
