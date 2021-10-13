class User < ApplicationRecord
	validates :email,:name ,presence: true ,uniqueness: true
	validates :password_digest ,presence: true 
	#length: { in:8..15}
	validates_confirmation_of :password_digest, :message => "password should match password"
	has_many :posts
	has_many :follower_follows, foreign_key: :followee_id, class_name: "Follow" 
    has_many :followers, through: :follower_follows, source: :follower
    has_many :followee_follows, foreign_key: :follower_id, class_name: "Follow"
    has_many :followees, through: :followee_follows, source: :followee
end