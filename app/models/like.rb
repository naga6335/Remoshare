class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validate :user_id, presence: true, uniqueness: { scope: :post_id }
  validate :post_id, presence: true
end
