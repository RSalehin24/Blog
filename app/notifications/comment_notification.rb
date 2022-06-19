# To deliver this notification:
#
# CommentNotification.with(post: @post).deliver_later(current_user)
# CommentNotification.with(post: @post).deliver(current_user)

class CommentNotification < Noticed::Base
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
    @post = Post.find_by(id: params[:comment][:post_id])
    @comment = Comment.find_by(id: params[:comment][:id])
    @user = User.find_by(id: @post.user_id)
    "#{@user.first_name} #{@user.last_name} comment on #{@post.title.truncate_words(10)}"
  end
  #
  def url
    posts_path()
  end
end
