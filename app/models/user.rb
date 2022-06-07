class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
         
         has_many :posts, dependent: :destroy
         validates :first_name, :last_name, :username, presence: true
         validates :username, uniqueness: true

         has_one_attached :image, dependent: :destroy
end
