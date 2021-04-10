module UsersHelper
  def most_new_message_preview(room)
    message = room.messages.order(updated_at: :desc).limit(1)
    message = message[0]
    if message.present?
      tag.p message.message.to_s, class: "block ml-auto mb-5"
    else
      tag.p "まだメッセージはありません", class: "block ml-auto mb-5"
    end
  end
end
