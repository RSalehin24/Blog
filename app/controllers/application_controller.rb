class ApplicationController < ActionController::Base
  before_action :set_notifications, if: :current_user
  
  include Pagy::Backend
  before_action :turbo_frame_request_variant


  private
  def set_notifications
    @notifications = Notification.where(recipient: current_user).newest_first.limit(9)
    @unread = @notifications.unread
    @read = @notifications.read
  end

  def turbo_frame_request_variant
    request.variant = :turbo_frame if turbo_frame_request?
  end
end
