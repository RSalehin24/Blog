class FollowController < ApplicationController

  def post_follow_request
    @requester = User.find_by(id: params[:id])
    @request = Request.create(requestee: current_user, requester: @requester)

    puts
    puts @request
    puts current_user.requesters
    puts @requester.requestees
    puts

    respond_to do |format|
      if @request.save
        format.turbo_stream
      end
    end
  end
end