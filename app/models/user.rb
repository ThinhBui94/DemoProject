class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :posts

  has_many :comments
  has_many :post_comments, through: :comments, class_name: :Post

  has_many :like_posts
  has_many :post_likes, through: :like_posts, class_name: :Post
end
