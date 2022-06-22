class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
         
         has_many :posts, dependent: :destroy
         validates :first_name, :last_name, :username, :email, presence: true
         validates :username, uniqueness: true

         has_one_attached :image, dependent: :destroy


         has_many :requester_requests, foreign_key: :requestee_id, class_name: "Request"
         has_many :requesters, through: :requester_requests, source: :requester

         has_many :requestee_requests, foreign_key: :requester_id, class_name: "Request"
         has_many :requestees, through: :requestee_requests, source: :requestee


         has_many :follower_requests, foreign_key: :followee_id, class_name: "Follow"
         has_many :followers, through: :follower_requests, source: :follower

         has_many :followee_requests, foreign_key: :follower_id, class_name: "Follow"
         has_many :followees, through: :followee_requests, source: :followee

         has_many :notifications, as: :recipient, dependent: :destroy

         scope :all_except, -> (user) { where.not(id: user) }
         after_create_commit { broadcast_append_to "users" }
end