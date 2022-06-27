class ChatUsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @users = Set.new

    current_user.followers.each do |follower|
      @users << follower
    end

    current_user.followees.each do |followee|
      @users << followee
    end

    if current_user.followees.include?(@user)
      @room = Room.new 
      @rooms = Room.public_rooms
      @room_name = get_name(@user, current_user)
      @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, current_user], @room_name)

      @message = Message.new
      @messages = @single_room.messages.order(created_at: :asc)
      render 'rooms/index'
    end
  end

  private
  def get_name(user1, user2)
    user = [user1, user2].sort
    "private_#{user[0].id}_#{user[1].id}"
  end

end
