class Post < ApplicationRecord
  belongs_to :user

  has_many :comments
  has_many :user_comments, through: :comments, class_name: :User

  has_many :like_posts
  has_many :user_likes, through: :like_posts, class_name: :User

  validates :title, presence: true
  validates :body, presence: true
  validates :user_id, presence: true
end
