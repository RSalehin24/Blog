class CommentReply < ApplicationRecord
  belongs_to :comment

  validates :replier, :reply, presence: true

  after_create_commit :notify_recipient
  before_destroy :cleanup_notifications
  has_noticed_notifications model_name: 'Notification'

  def notify_recipient
    CommentReplyNotification.with(reply: self, comment: comment, post: comment.post).deliver_later(comment.post.user)
  end

  def cleanup_notifications
    notifications_as_comment_reply.destroy_all
  end
end
