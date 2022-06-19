# To deliver this notification:
#
# CommentReplyNotification.with(post: @post).deliver_later(current_user)
# CommentReplyNotification.with(post: @post).deliver(current_user)

class CommentReplyNotification < Noticed::Base
  # Add your delivery methods
  #
  deliver_by :database
  # deliver_by :email, mailer: "UserMailer"
  # deliver_by :slack
  # deliver_by :custom, class: "MyDeliveryMethod"

  # Add required params
  #
  # param :post

  # Define helper methods to make rendering easier.
  #
  def message
    @comment = Comment.find_by(id: params[:comment][:id])
    @post = Post.find_by(id: @comment.post_id)
    @user = User.find_by(id: @post.user_id)
    "#{@user.first_name} #{@user.last_name} replied on #{@comment.body.truncate_words(10)} on #{@post.title.truncate_words(10)}"
  end
  #
  def url
    posts_path()
  end
end
