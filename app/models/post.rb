class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, :body, :author, presence: true
  validates :user_id, presence: true
  has_many_attached :images
end
