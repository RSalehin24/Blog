class AdminDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :for_admin, only: [ :get_admin_dashboard ] 

  def get_admin_dashboard
    @posts_tobe_approved = Post.where(is_approved: false).count
    @requests = User.where(is_requested: true).count
    @categories = Category.all.count
  end

  def for_admin
    redirect_to posts_path, notice: "Not a path for you!" if !current_user.is_admin?
  end

end