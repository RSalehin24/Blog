class Like < ApplicationRecord
  belongs_to :post
  validates :username, presence: true
end
