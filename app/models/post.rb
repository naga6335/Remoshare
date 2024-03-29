class Post < ApplicationRecord
  belongs_to :user
  validates  :title,          presence: true, length: { maximum: 30}
  validates  :content,        presence: true, length: { maximum: 400 }
  validates  :image,          presence: true
  validates  :price,          presence: true
  validates  :issue,          presence: true
  has_many   :comments,      dependent: :destroy
  has_many   :users,           through: :likes
  has_many   :likes,         dependent: :destroy
  has_many   :notifications, dependent: :destroy
  validates  :user_id,        presence: true
  has_many   :tagmaps,       dependent: :destroy
  has_many   :tags,            through: :tagmaps
  mount_uploader :image, ImageUploader

  def liked_by(user_id)
    likes.where(user_id: user_id).exists?
  end

  def self.create_all_ranks
    Post.find(Like.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
  end

  def create_notification_like(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'like'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(post_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment(current_user, comment_id, temp_id['user_id'])
    end
    save_notification_comment(current_user, comment_id, user_id) if temp_ids.blank?
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

  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags
    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name: old)
    end
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(tag_name: new)
      self.tags << new_post_tag
    end
  end

  def self.search(search)
    search != ""
    Post.where(["title LIKE ? OR content LIKE ? OR issue LIKE ?", "%#{search}%", "%#{search}%", "%#{search}%"])
  end

  def self.sort(selection)
    case selection
    when 'price'
      return all.order(price: :DESC)
    when 'lessprice'
      return all.order(price: :ASC)
    when 'likes'
      return find(Like.group(:post_id).order(Arel.sql('count(post_id) desc')).pluck(:post_id))
    when 'dislikes'
      return find(Like.group(:post_id).order(Arel.sql('count(post_id) asc')).pluck(:post_id))
    when 'comments'
      return find(Comment.group(:post_id).order(Arel.sql('count(post_id) desc')).pluck(:post_id))
    when 'discomments'
      return find(Comment.group(:post_id).order(Arel.sql('count(post_id) asc')).pluck(:post_id))
    end
  end

end
