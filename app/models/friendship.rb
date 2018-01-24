class Friendship < ApplicationRecord
  belongs_to :user, class_name: :User
  belongs_to :friend, class_name: :User

  scope :accepted, -> {where status: "accepted"}
end
