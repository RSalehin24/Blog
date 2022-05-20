Rails.application.routes.draw do
  get 'your_posts/get_posts'
  resources :posts do
    resources :comments
  end
  
  devise_for :users
  root 'home#index'
  get 'home/about_us', 'home#about_us'
  
end
