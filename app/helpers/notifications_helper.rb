module NotificationsHelper
  def notification_form(notification)
    @visitor = notification.visitor
    @comment = nil
    @visitor_comment = notification.comment_id
    case notification.action
    when 'follow'
      tag.a(notification.visitor.name, href: user_path(@visitor), class: 'font-bold hover:text-gray-500') + 'さんがあなたをフォローしました'
    when 'like'
      tag.a(notification.visitor.name, href: user_path(@visitor), class: 'font-bold hover:text-gray-500') + 'さんが' + tag.a('あなたの投稿', href: post_path(notification.post_id), class: 'font-bold hover:text-gray-500') + 'にいいねしました'
    when 'comment' then
      @comment = Comment.find_by(id: @visitor_comment)&.comment
      tag.a(@visitor.name, href: user_path(@visitor), class: 'font-bold hover:text-gray-500') + 'さんが' + tag.a('あなたの投稿', href: post_path(notification.post_id), class: 'font-bold hover:text-gray-500') + 'にコメントしました'
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
