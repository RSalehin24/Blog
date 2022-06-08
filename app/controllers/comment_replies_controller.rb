class CommentRepliesController < ApplicationController
  
  def create
    @comment = Comment.find(params[:comment_id])
    @comment_replies = @comment.comment_replies.all.count
    @comment_reply = @comment.comment_replies.create(comment_reply_params)

    respond_to do |format|
      if @comment.save
        format.turbo_stream
      else
        format.html { redirect_to posts_path, notice: "Something is wrong." }
      end
    end
  end

  private
    def comment_reply_params
      params.permit(:replier, :reply)
    end
end
