class Comment < ApplicationRecord
  belongs_to :post
  has_many :comment_replies, dependent: :destroy

  validates :commenter, :body, presence: true

  after_create_commit :notify_recipient
  before_destroy :cleanup_notifications
  has_noticed_notifications model_name: 'Notification'

  def notify_recipient
    CommentNotification.with(comment: self, post: post).deliver_later(post.user)
  end

  def cleanup_notifications
    notifications_as_comment.destroy_all
  end
end
