class YourPostsController < ApplicationController
  before_action :authenticate_user!
  
  def get_posts
    @posts = Post.where(user_id: current_user.id, is_approved: true).order(updated_at: :desc)
  end

  def delete
    @posts = Post.where(is_approved: false)
    @post = Post.find_by(id: params[:_id])
    @post.destroy

    respond_to do |format|
      format.turbo_stream
    end
  end
end
