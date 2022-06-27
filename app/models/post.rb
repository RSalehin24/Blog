class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, :body, :author, presence: true
  validates :user_id, :category_id, presence: true
  has_many_attached :images


  has_noticed_notifications model_name: 'Notification'
  has_many :notifications, through: :user, dependent: :destroy
end
