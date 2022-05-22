class HandlePostsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_admin, only: [:posts_tobe_approved]
  before_action :pending_posts, only: [:pending_posts]

  def posts_tobe_approved
    @posts = Post.where(is_approved: false)
  end

  def pending_posts
    @your_pending_posts = Post.where(user_id: current_user.id, is_approved: false)
  end

  def admin
    redirect_to posts_path, notice: "Not a path for you!" if current_user.is_admin?
  end

  def is_admin
    redirect_to posts_path, notice: "Not a path for you!" if !current_user.is_admin?
  end
end
