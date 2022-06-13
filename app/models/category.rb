class Category < ApplicationRecord
  has_many :posts, dependent: :nullify

  validates :name, uniqueness: true
end
