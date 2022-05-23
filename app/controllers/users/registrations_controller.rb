# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  
  def create
    if resource_params[:password] == resource_params[:password_confirmation]
      @user = User.find_by(email: resource_params[:email]) 
      if @user.nil?
        @user0 = User.find_by(username: resource_params[:username]) 
        if @user0.nil?
          super
        else
          redirect_to new_user_registration_path, notice: "Given username has already been used, please try with a different one!"
        end
      else
        redirect_to new_user_session_path, notice: "User already exists with this Email, Please Sign in!"
      end
    else
      redirect_to new_user_registration_path, notice: "Password doesn't match!"
    end
  
    
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute, :date_of_birth, :first_name, :last_name, :username])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute, :date_of_birth, :first_name, :last_name, :twitter, :instagram, :username, :image])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
