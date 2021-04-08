class NotificationsController < ApplicationController

  def index
    @notifications = current_user.passive_notifications.page(params[:page]).per(10)
  end

  def destroy
    @notifications =current_user.passive_notifications.destroy_all
    redirect_to notifications_path
  end
end
