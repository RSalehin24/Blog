class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.create(params[:username])
    redirect_to post_path(@post)
  end
end
