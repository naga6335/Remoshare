class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:success] = "ログインしました"
      redirect_back_or root_url
    else
      flash.now[:danger] = 'メールアドレスとパスワードが一致しません'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end

end
