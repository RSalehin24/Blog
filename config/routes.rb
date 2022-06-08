Rails.application.routes.draw do
  resources :categories

  post "/comment/reply/new", to: "comment_replies#create"

  post "handle_posts/edit", to: "handle_posts#update_post_approve" 
  get "handle_posts/edit_post_approve", to: "handle_posts#edit_post_approve" 

  delete 'your_posts/delete', to: 'your_posts#delete'
  
  delete 'handle_posts/pending/delete', to: 'handle_posts#pending_delete'
  delete 'handle_posts/approve/delete', to: 'handle_posts#approve_delete'
  
  post 'posts/:id', to: "posts#approve_post"

  get '/handle_posts/pending_posts', to: 'handle_posts#pending_posts'
  get '/handle_posts/posts_tobe_approved', to: 'handle_posts#posts_tobe_approved'

  get 'change_role/change_is_admin'
  post 'change_role/change_is_admin', to: 'change_role#update_is_admin'
  get 'change_role/role_change_requests', to: 'change_role#role_change_requests'
  post 'change_role/disapprove_request', to: 'change_role#disapprove_request'
  post 'change_role/requested_admin_role', to: 'change_role#requested_admin_role'

  get 'your_posts/get_posts'

  resources :posts do
    post '/likes', to: 'likes#create'
    delete '/likes', to: 'likes#destroy'
    delete '/delete_image', to: "posts#delete_image"
    resources :comments
  end
  
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  root "home#index"
  
  get 'home/about_us', to: 'home#about_us'
end
