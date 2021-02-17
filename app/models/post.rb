class Post < ApplicationRecord
  belongs_to :user
  has_many   :comments, dependent: :destroy
  has_many   :likes,    dependent: :destroy
  has_many   :users,      through: :likes
  has_many   :notifications, dependent: :destroy

  validates  :user_id,   presence: true
  validates  :content,   presence: true, length: { maximum: 200 }
  validates  :image, presence: true
  default_scope -> { order(created_at: :desc) }
  mount_uploader :image, ImageUploader

  def liked?(user)
    likes.where(user_id: user.id).exists?
  end

  def create_notification_like(current_user)
    notification = current_user.active_notifications.new(
      comment_id: nil,
      post_id: id,
      visited_id: user_id,
      action: 'like'
      )
    if notification.visitor_id == notification.visited_id
       notification.checked = true
    end
    notification.save if notification.valid?
  end

  def create_notification_comment(current_user, comment_id)
    temp_ids = Comment.where(post_id: id).select(:user_id).where.not("user_id = ? or user_id = ?", current_user.id, user_id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment(current_user, comment_id, temp_id['user_id']) #ここでバグが出ている
    end
      save_notification_comment(current_user, comment_id, user_id)
  end

  def save_notification_comment(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      post_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
      notification.save if notification.valid?
  end
end
