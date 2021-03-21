class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validate :user_id
  validate :post_id
end
