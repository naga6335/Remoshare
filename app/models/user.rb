class User < ApplicationRecord
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 15 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,    presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  mount_uploader :avatar, AvatarUploader

  has_many :posts,        dependent: :destroy
  has_many :comments,     dependent: :destroy
  has_many :likes,        dependent: :destroy
  has_many :like_posts,     through: :likes, source: :post
  has_many :active_notifications,  class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  has_many :active_relation,  class_name:  "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relation, class_name:  "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relation,  source: :followed
  has_many :followers, through: :passive_relation, source: :follower

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
                                                  BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    if remember_digest.nil?
      false
    else
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def own?(object)
    id == object.user_id
  end

  def like(post)
    likes.find_or_create_by(post: post)
  end

  def like?(post)
    like_posts.include?(post)
  end

  def unlike(post)
    like_posts.delete(post)
  end

   # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーのフォローを外す
  def unfollow(other_user)
    active_relation.find_by(followed_id: other_user.id).destroy
  end

  # フォローしていればtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end

   def create_notification_follow(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
end
