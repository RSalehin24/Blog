class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :correct_user_or_admin, only: [:destroy, :edit, :update]
  before_action :approved, only: [:show]
  before_action :not_approved, only: [:update]
  before_action :for_admin, only: [ :update_after_approve ]

  # GET /posts or /posts.json
  def index
    @followers = current_user.followers
    @requesters = current_user.requesters
    @posts = Post.where(is_approved: true).where.not(user_id: current_user.id).order(updated_at: :desc)
  end

  def your_posts
    @posts = Post.where(user_id: current_user.id).order(updated_at: :desc)
  end

  # GET /posts/1 or /posts/1.json
  def show
    format.html {redirect_to posts_path, notice: "The path is void" }
  end

  # GET /posts/new
  def new
    @post = Post.new
    @categories = Category.all.order(:name)
    @categories_array = Array.new
    @categories.each do |category|
      @categories_array.push([category.name, category.id])
    end
  end

  # GET /posts/1/edit
  def edit
    @categories = Category.all.order(:name)
    @categories_array = Array.new
    @categories.each do |category|
      @categories_array.push([category.name, category.id])
    end
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    @categories = Category.all.order(:name)
    @categories_array = Array.new
    @categories.each do |category|
      @categories_array.push([category.name, category.id])
    end

    respond_to do |format|
      if @post.save
        format.html { redirect_to handle_posts_pending_posts_path, notice: "Your post was successfully placed for Admin approval" }
      else
        format.html { redirect_to your_posts_get_posts_path, notice: @post.errors }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.turbo_stream
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @posts = Post.all
    @post.destroy
    respond_to do |format|
      format.turbo_stream
    end
  end

  def delete_image
    @image = ActiveStorage::Blob.find_signed(params[:id]).purge
    @post = Post.find(params[:post_id])
    redirect_to edit_post_path(@post), status: :see_other, notice: "Image was successfully removed"
  end

  def approve_post
    @posts = Post.where(is_approved: false)
    @post = Post.find(params[:id])
    @post.update_column(:is_approved, true)

    respond_to do |format|
      format.turbo_stream
    end
  end

  def edit_post_approved
    @post = Post.find(params[:id])
    @categories = Category.all.order("name")
    @categories_array = Array.new
    @categories.each do |category|
      @categories_array.push([category.name, category.id])
    end
  end

  def update_after_approved
    @post = Post.find(params[:post_id])
    
    if @post.is_approved?
      respond_to do |format|
        if @post.update(category_id: params[:category])
          format.turbo_stream
        end
      end
    end
  end

  def correct_user
    @post = current_user.posts.find_by(id: params["id"])
    redirect_to your_posts_get_posts_path, notice: "Not Authorized to edit this Post!" if @post.nil?
  end

  def correct_user_or_admin
    @post = Post.find_by(id: params["id"])
    redirect_to your_posts_get_posts_path, notice: "Not Authorized to delete this Post!" if !current_user.is_admin? && !(@post.user_id == current_user.id)
  end


  def approved
    @post = Post.find_by(id: params["id"])
    redirect_to your_posts_get_posts_path if !@post.is_approved
  end

  def not_approved
    @post = Post.find_by(id: params["id"])
    redirect_to posts_path if @post.is_approved
  end

  def for_admin
    redirect_to posts_path, notice: "Not a path for you!" if !current_user.is_admin?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :author, :user_id, :disapprove, :category_id, images: [])
    end
end
