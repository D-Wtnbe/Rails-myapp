class SessionsController < ApplicationController

  def new
  end

#ログイン
  def create
    user = User.find_by(userid: params[:session][:userid].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      flash[:info] = "ログインしました"
      redirect_to user

    else
      flash.now[:danger] = 'ユーザーIDもしくはパスワードが間違っています'
      render :new
    end
  end

#ログアウト
  def destroy
    log_out if logged_in?
    flash[:notice] = "ログアウトしました"
    redirect_to root_url
  end
end
