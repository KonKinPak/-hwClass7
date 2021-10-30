class Post < ApplicationRecord
  belongs_to :user 
  has_many :likes ,dependent: :destroy
  has_many :user_likes ,through: :likes, source: :user

  def get_users_like_name
   users = []
   self.user_likes.each do |user|
    users.push(user.name)
   end
   return users
  end  

end
