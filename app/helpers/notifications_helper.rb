module NotificationsHelper
  def notification_form(notification)
    @visitor = notification.visitor
    @comment = nil
    @visitor_comment = notification.comment_id
    case notification.action
    when 'follow'
      tag.a(notification.visitor.name, href: user_path(@visitor)) + 'さんがあなたをフォローしました'
    when 'like'
      tag.a(notification.visitor.name, href: user_path(@visitor)) + 'さんが' + tag.a('あなたの投稿', href: post_path(notification.post_id)) + 'にいいねしました'
    when 'comment' then
      @comment = Comment.find_by(id: @visitor_comment)
      @comment_content =@comment
      tag.a(@visitor.name, href: user_path(@visitor)) + 'がさん' + tag.a(notification.visited.name, href: post_path(notification.post_id)) + 'にコメントしました'
    end
  end
end
