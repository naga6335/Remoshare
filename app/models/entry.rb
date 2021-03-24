class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validate  :user_id, presence: true, uniqueness: { scope: :room_id }
  validate  :room_id, presence: true
end
