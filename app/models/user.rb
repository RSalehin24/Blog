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

        #  scope :all_except, -> (user) { where.not(id: user) }
        #  after_create_commit { broadcast_append_to "users" }
        #  after_update_commit { broadcast_update}

        #  enum status: %i[offline away online]
        #  has_many :messages


        #  after_commit :add_default_avatar, on: %i[create update]

        # def chat_avatar
        #   image.variant(resize_to_limit: [50, 50])
        # end

        # def status_to_css
        #   case status
        #   when 'online'
        #     'bg-success'
        #   when 'away'
        #     'bg-warning'
        #   when 'offline'
        #     'bg-dark'
        #   else
        #     'bg-dark'
        #   end
        # end

         private

          def add_default_avatar
            return if image.attached?

            image.attach(
              io: File.open(Rails.root.join('app', 'assets', 'images', 'default_avatar.jpeg')),
              filename: "default_avatar.jpeg",
              content_type: 'image/jpeg'
            )
          end


          # def broadcast_update
          #   broadcast_replace_to 'user_status', partial: 'users/status', user: self
          # end
end