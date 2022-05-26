class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update]
  before_action :correct_user_or_admin, only: [:destroy]
  before_action :approved, only: [:show, :edit]

  # GET /posts or /posts.json
  def index
    @posts = Post.where(is_approved: true)
  end

  def your_posts
    @posts = Post.where(user_id: current_user.id)
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_url(@post), notice: "Your post was successfully placed for Admin approval" }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated" }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end


  def delete
    @post = Post.find_by(id: params[:_id])
    @post.destroy
    redirect_to handle_posts_posts_tobe_approved_path, status: :see_other, notice: "Post was successfully deleted"
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    redirect_to posts_path, status: :see_other, notice: "Post was successfully deleted"
  end

  def approve_post
    @post = Post.find(params[:id])
    @post.update_column(:is_approved, true)
    redirect_to  handle_posts_posts_tobe_approved_path, notice: "Post has been successfully approved!"
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :body, :author, :user_id, images: [])
    end
end
