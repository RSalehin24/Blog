class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  validates :title, :body, :author, presence: true

  has_many_attached :images
end
