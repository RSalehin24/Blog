class MessagesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    if !msg_params[:body].empty? || msg_params[:attachments].count > 1
      @message = current_user.messages.create(
        body: msg_params[:body], 
        room_id: params[:room_id],
        attachments: msg_params[:attachments]
      )
    end
  end

  private
  def msg_params
    params.require(:message).permit(:body, attachments: [])
  end
end
