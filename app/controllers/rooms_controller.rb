class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_status

  def index
    @room = Room.new
    @rooms = Room.public_rooms
    @users = Set.new

    current_user.followers.each do |follower|
      @users << follower
    end

    current_user.followees.each do |followee|
      @users << followee
    end

    render "index"
  end

  def show
    @single_room =  Room.find_by(id: params[:id])
    @room = Room.new
    @rooms = Room.public_rooms

    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)

    @users = current_user.followees
    render "index"
  end


  def create
    @room = Room.create(name: params[:name])
    @room.save
  end


  private

  def set_status
    current_user.update!(status: User.statuses[:online]) if current_user
  end

end