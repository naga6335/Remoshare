class Tag < ApplicationRecord
  has_many :tagmaps, dependent: :destroy, foreign_key: 'tag_id'
  has_many :posts, through: :tagmaps
end
