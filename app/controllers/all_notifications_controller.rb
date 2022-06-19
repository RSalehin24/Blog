class AllNotificationsController < ApplicationController
  before_action :authenticate_user!

  def mark_notification_as_read
    if current_user
     
      @notification_to_mark_as_read = Notification.find_by(id: params[:id])
      @read = @notifications.unread.count
      
      respond_to do |format|
        if @notification_to_mark_as_read.update(read_at: Time.zone.now)
          @notifications = Notification.where(recipient: current_user).newest_first.limit(9)
          @unread = @notifications.unread
          format.turbo_stream
        end
      end
     
    end
  end
end