class GuestsessionController < ApplicationController
  def create
    user = User.find_or_create_by!(name: guestuser, email: 'guest@example.com') do |user|
    user.password = SecureRandom.urlsafe_base64
    end
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
end
