class Post < ApplicationRecord
  belongs_to :user
  has_many   :comments, dependent: :destroy
  validates  :user_id,   presence: true
  validates  :content,   presence: true, length: { maximum: 200 }
  validates  :image, presence: true
  default_scope -> { order(created_at: :desc) }
  mount_uploader :image, ImageUploader
end
