class ChangeRoleController < ApplicationController
  before_action :authenticate_user!
  before_action :admin, only: [:change_is_admin, :requested_admin_role]
  #before_action :is_admin, only: [:disapprove_request, :update_is_admin, :role_change_requests]

  def change_is_admin
  end

  def role_change_requests
    @users = User.where(is_requested: true)
  end

  def disapprove_request
    @user = User.find(params[:_id])
    @user.update_column(:is_requested, false)
    redirect_to change_role_role_change_requests_path, notice: "Request has been disapproved!"
  end

  def requested_admin_role
    @user = User.find(current_user.id)
    if @user.is_admin?
      redirect_to your_posts_get_posts_path, notice: "You are already an Admin!"
    elsif @user.is_requested?
      redirect_to your_posts_get_posts_path, notice: "You have already placed a request!"
    else 
      @user.update_column(:is_requested, true)
      redirect_to your_posts_get_posts_path, notice: "Your Request has been placed succesfully!"
    end
  end

  def update_is_admin
    @user = User.find(params[:_id])
    if @user.is_admin?
      redirect_to change_role_role_change_requests_path, notice: "Already an Admin!"
    elsif @user.is_requested?
      @user.update_column(:is_admin, true)
      @user.update_column(:is_requested, false)
      redirect_to change_role_role_change_requests_path, notice: "Request for being an Admin has been approved!"
    end
  end

  def admin
    redirect_to posts_path, notice: "Not a path for you!" if current_user.is_admin?
  end

  def is_admin
    redirect_to posts_path, notice: "Not a path for you!" if !current_user.is_admin?
  end
end
