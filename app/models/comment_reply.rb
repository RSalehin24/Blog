class CommentReply < ApplicationRecord
  belongs_to :comment

  validates :replier, :reply, presence: true
end
