class Relationship < ApplicationRecord
  # フォローされることを考える
  belongs_to :following, class_name: "User"
  # フォローのみを考える
  belongs_to :follower, class_name: "User"
  validates :following_id, presence: true
  validates :follower_id, presence: true
end
