# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    user = User.find_for_authentication(email: resource_params[:email])
    if user.nil?
      redirect_to new_user_registration_path, notice: "No user exists with the Email, Open an account!"
    elsif !user.valid_password?(resource_params[:password])
      redirect_to new_user_session_path, notice: "Password not valid, please try again!"
    else
      @user = User.find_by(email: resource_params[:email])
      if @user.nil?
        redirect_to new_user_registration_path, notice: "No user exists with the Email, Open an account!"
      else
        super
      end
    end
  end

  # DELETE /resource/sign_out
  def destroy
    ActionCable.server.remote_connections.where(current_user: current_user).disconnect
    current_user.update(status: User.statuses[:offline])
    super
  end

  protected

  def after_sign_in_path_for(resource)
    '/user/feed'
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
