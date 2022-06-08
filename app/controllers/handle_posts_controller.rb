class HandlePostsController < ApplicationController
  before_action :authenticate_user!
  before_action :for_admin, only: [:posts_tobe_approved, :approve_delete, :edit_post_approve, :update_post_approve]

  def posts_tobe_approved
    @posts = Post.where(is_approved: false)
  end

  def pending_posts
    @your_pending_posts = Post.where(user_id: current_user.id, is_approved: false).order(updated_at: :desc)
  end

  def approve_delete
    @posts = Post.where(is_approved: false)
    @post = Post.find_by(id: params[:_id])
    @post.destroy

    respond_to do |format|
      format.turbo_stream
    end
  end

  def edit_post_approve
    @post = Post.find(params[:id])
    @categories = Category.all
    @categories_array = Array.new
    @categories.each do |category|
      @categories_array.push([category.name, category.name])
    end
  end

  def update_post_approve
    @post = Post.find(params[:post_id])
    
    if !@post.is_approved?
      respond_to do |format|
        if @post.update(category: params[:category])
          format.turbo_stream
        end
      end
    end
  end


  def pending_delete
    @posts = Post.where(user_id: current_user.id, is_approved: false)
    @post = Post.find_by(id: params[:_id])
    @post.destroy

    respond_to do |format|
      format.turbo_stream
    end
  end

  def for_not_admin
    redirect_to posts_path, notice: "Not a path for you!" if current_user.is_admin?
  end

  def for_admin
    redirect_to posts_path, notice: "Not a path for you!" if !current_user.is_admin?
  end
end
