class YourPostsController < ApplicationController
  before_action :authenticate_user!
  
  def get_posts
    @posts = Post.where(user_id: current_user.id)
  end
end
