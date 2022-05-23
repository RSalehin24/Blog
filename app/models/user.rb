class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
         has_many :posts, dependent: :destroy
         validates :first_name, :last_name, :username, :date_of_birth, presence: true
         validates :date_of_birth, uniqueness: true
end
