Rails.application.routes.draw do
  resources :posts

  devise_for :users, controllers: { registrations: 'users/registrations' }

  get 'home/index'
  get 'home/about_us'
  
  root 'home#index'
end
