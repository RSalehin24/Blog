class UserDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action only: [ :get_admin_dashboard ] 

  def get_user_dashboard
    @your_posts = Post.where(user_id: current_user.id).count
    @pending_posts = Post.where(user_id: current_user.id, is_approved: false, disapprove: false).count
    @disapproved_posts = Post.where(user_id: current_user.id, is_approved: false, disapprove: true).count
  end
end