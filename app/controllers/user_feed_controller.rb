class UserFeedController < ApplicationController

  before_action :authenticate_user!
  
  def get_user_feed
    @followers = current_user.followers
    @requesters = current_user.requesters

    @posts = Array.new()

    @followers.each do |follower|
      follower.posts.each do |post|
        if post.is_approved
          @posts.push(post)
        end
      end
    end

    @is_empty = @posts.empty?
  end

end