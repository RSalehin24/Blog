class ChatController < ApplicationController
  before_action :authenticate_user!

  def get_chat_dashboard
    @room = Room.new
    @rooms = Room.public_rooms
    @users = User.all_except(current_user)
  end

  def create_room
    @room = Room.create(name: params[:name])
    @room.save
  end

end