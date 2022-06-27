class UserDashboardController < ApplicationController
  before_action :authenticate_user!
  before_action only: [ :get_admin_dashboard ] 

  def get_user_dashboard
    @your_posts = Post.where(user_id: current_user.id, is_approved: true, disapprove: false).count
    @pending_posts = Post.where(user_id: current_user.id, is_approved: false, disapprove: false).count
    @disapproved_posts = Post.where(user_id: current_user.id, is_approved: false, disapprove: true).count
    
    @requestees = current_user.requestees
    @requesters = current_user.requesters

    @followees = current_user.followees
    @followers = current_user.followers
  end
end