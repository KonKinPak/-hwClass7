class Post < ApplicationRecord
  belongs_to :user 
  has_many :likes ,dependent: :destroy
  has_many :user_likes ,through: :likes, source: :user
end
