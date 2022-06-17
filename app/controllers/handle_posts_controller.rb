class HandlePostsController < ApplicationController
  before_action :authenticate_user!
  before_action :for_admin, only: [:disapprove, :posts_tobe_approved, :approve_delete, :edit_post_approve, :update_post_approve]

  def posts_tobe_approved
    @followers = current_user.followers
    @requesters = current_user.requesters
    @posts = Post.where(is_approved: false, disapprove: false)
  end

  def pending_posts
    @your_pending_posts = Post.where(user_id: current_user.id, is_approved: false, disapprove: false).order(updated_at: :desc)
  end

  def approve_delete
    @posts = Post.where(is_approved: false, disapprove: false)
    @post = Post.find_by(id: params[:_id])
    @post.destroy

    respond_to do |format|
      format.turbo_stream
    end
  end

  def edit_post_approve
    @post = Post.find(params[:id])
    @categories = Category.all.order("name")
    @categories_array = Array.new
    @categories.each do |category|
      @categories_array.push([category.name, category.id])
    end
  end

  def update_post_approve
    @post = Post.find(params[:post_id])
    
    if !@post.is_approved?
      respond_to do |format|
        if @post.update(category_id: params[:category])
          format.turbo_stream
        end
      end
    end
  end

  def disapprove
    @posts = Post.where(is_approved: false, disapprove: false)
    @post = Post.find_by(id: params[:post_id])
    
    if @post.disapprove_count.nil?
      @disapprove_count = 1
    else
      @disapprove_count = @post.disapprove_count + 1
    end
    

    if !@post.is_approved?
      respond_to do |format|
        if Post.where(id: params[:post_id]).update_all(disapprove: true, disapprove_message: params[:disapprove_message], disapprove_count: @disapprove_count)
          format.turbo_stream
        end
      end
    end
  end

  def disapproved_posts
    @your_disapproved_posts = Post.where(user_id: current_user.id, is_approved: false, disapprove: true)
  end

  def disapprove_edit
    @categories = Category.all.order("name")
    @categories_array = Array.new
    @categories.each do |category|
      @categories_array.push([category.name, category.id])
    end

    @post = Post.find(params[:id])
  end

  def disapprove_update
    @post = Post.find(params[:post_id])
    @posts = Post.where(user_id: current_user.id, is_approved: false, disapprove: true)

    respond_to do |format|
      if Post.where(id: params[:post_id]).update_all(disapprove: false, disapprove_message: nil, title: params[:title], body: params[:body])
        format.turbo_stream
      end
    end
  end

  def disapprove_delete
    @posts = Post.where(user_id: current_user.id, is_approved: false, disapprove: true)
    @post = Post.find_by(id: params[:id])
    @post.destroy

    respond_to do |format|
      format.turbo_stream
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

  def disapprove_update_params
    params.permit(:title, :body, :category_id, images: [])
  end
end
