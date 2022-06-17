class UserFeedController < ApplicationController

  def get_user_feed
    @followers = current_user.followers
    @requesters = current_user.requesters

    @posts = Array.new()

    @followers.each do |follower|
      follower.posts.each do |post|
        @posts.push(post)
      end
    end

    @is_empty = @posts.empty?
  end

end