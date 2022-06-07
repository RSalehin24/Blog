class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :approved

  def create
    @post = Post.find(params[:post_id])
    @like = @post.likes.create(create_params)

    respond_to do |format|
      if @like.save
        format.turbo_stream
      else
        format.html { redirect_to posts_path, notice: "Something is wrong." }
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @like = @post.likes.find(params[:like_id])

    respond_to do |format|
      if @like.destroy
        format.turbo_stream
      else
        format.html { redirect_to posts_path, notice: "Something is wrong." }
      end
    end
  end

  def approved
    @post = Post.find(params[:post_id])
    redirect_to your_posts_get_posts_path if !@post.is_approved
  end

  private
    def create_params
      params.permit(:username, :post_id)
    end
    def delete_params
      params.permit(:like_id, :post_id)
    end
end
