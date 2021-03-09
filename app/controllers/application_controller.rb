class ApplicationController < ActionController::Base
  include SessionsHelper

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:alert] = "ログインしてください"
      redirect_to login_path
    end
  end
end
