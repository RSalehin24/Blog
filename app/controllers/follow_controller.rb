class FollowController < ApplicationController
  before_action :authenticate_user!

  def post_follow_request
    @requester = User.find_by(id: params[:id])
    @request = Request.create(requestee: current_user, requester: @requester)

    respond_to do |format|
      if @request.save
        format.turbo_stream
      end
    end
  end

  def accept_follow_request
    @requestee = User.find_by(id: params[:id])
    @request = Request.find_by(requestee: @requestee, requester: current_user)
    @followers_is_empty = current_user.followees.empty?

    if !@request.nil?
      @follow = Follow.create(followee: @requestee, follower: current_user)
      
      if @follow.save
        @request.destroy
        @is_empty = User.find_by(id: current_user.id).requestees.empty?

        respond_to do |format|
          format.turbo_stream
        end
      else
        respond_to do |format|
          format.turbo_stream { render turbo_stream: turbo_stream.replace("alerts42", partial: "layouts/alerts", locals: { notice: "Something is wrong in accept_follow_request searching-follow-requestee" }) }
        end
      end

    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("alerts42", partial: "layouts/alerts", locals: { notice: "Something is wrong in accept_follow_request" }) }
      end
    end
  end

  def reject_follow_request
    @requestee = User.find_by(id: params[:id])
    @request = Request.find_by(requestee: @requestee, requester: current_user)
    
    if @request.destroy
      @is_empty = User.find_by(id: current_user.id).requestees.empty?

      respond_to do |format|
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("alerts42", partial: "layouts/alerts", locals: { notice: "Something is wrong in reject_follow_request" }) }
      end
    end
  end

  def delete_follow_request
    @requester = User.find_by(id: params[:id])
    @request = Request.find_by(requestee: current_user, requester: @requester)
    
    if @request.destroy
      @is_empty = User.find_by(id: current_user.id).requesters.empty?

      respond_to do |format|
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("alerts42", partial: "layouts/alerts", locals: { notice: "Something is wrong in delete_follow_request" }) }
      end
    end
  end

  def delete_follower
    @followee = User.find_by(id: params[:id])
    @follow = Follow.find_by(followee: @followee, follower: current_user)
    
    if @follow.destroy
      @is_empty = User.find_by(id: current_user.id).followees.empty?
      
      respond_to do |format|
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("alerts42", partial: "layouts/alerts", locals: { notice: "Something is wrong in delete_follower" }) }
      end
    end
  end

  def delete_following
    @follower = User.find_by(id: params[:id])
    @follow = Follow.find_by(followee: current_user, follower: @follower)
    
    if @follow.destroy
      @is_empty = User.find_by(id: current_user.id).followers.empty?

      respond_to do |format|
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("alerts42", partial: "layouts/alerts", locals: { notice: "Something is wrong in delete_following" }) }
      end
    end
  end

end