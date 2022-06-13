class YourPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [ :delete ]
  
  def get_posts
    @posts = Post.where(user_id: current_user.id, is_approved: true).order(updated_at: :desc)
    @categories = Category.all.order(:name)
    @categories_array = Array.new
    @categories.each do |category|
      @categories_array.push([category.name, category.id])
      puts category.id
    end
  end

  def delete
    @posts = Post.where(is_approved: false)
    @post = Post.find_by(id: params[:_id])
    @post.destroy

    respond_to do |format|
      format.turbo_stream
    end
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:_id])
    redirect_to your_posts_get_posts_path, notice: "Not Authorized to delete this Post!" if @post.nil?
  end
end
