class Comment < ApplicationRecord
  belongs_to :post
  has_many :comment_replies

  validates :commenter, :body, presence: true
end
