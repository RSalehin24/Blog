class ProfileController < ApplicationController
  before_action :authenticate_user!
  
  def get_profile
  end
end