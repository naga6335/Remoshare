class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :room
  validate  :user_id
  validate  :room_id
end
