class Comment < ApplicationRecord
  belongs_to :post
  has_many :comment_replies, dependent: :destroy

  validates :commenter, :body, presence: true
end
