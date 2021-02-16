class Post < ApplicationRecord
  belongs_to :user
  has_many   :comments, dependent: :destroy
  has_many   :likes,    dependent: :destroy
  has_many   :users,      through: :likes

  validates  :user_id,   presence: true
  validates  :content,   presence: true, length: { maximum: 200 }
  validates  :image, presence: true
  default_scope -> { order(created_at: :desc) }
  mount_uploader :image, ImageUploader

  def liked?(user)
    likes.where(user_id: user.id).exists?
  end
end
