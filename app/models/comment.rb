class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :user_id, presence: true
  validates :post_id, presence: true
  validates :content, presence: true

  scope :order_by_date_created,
  ->{select :id, :content, :user_id, :created_at and order date_created: :asc}
end
