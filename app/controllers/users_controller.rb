class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]

#ユーザー一覧
   def index
      @users = User.all
      end

#マイページ
   def show
     @user = User.find(params[:id])
   end

#新規作成
   def new
     @user = User.new
   end

#プロフィール編集
   def edit
     @user = User.find(params[:id])
   end

#アカウント作成
   def create
     @user = User.new(user_params)
     if @user.save
       log_in @user
       flash[:success] = "ようこそ！"
       redirect_to @user
     else
       render 'new'
     end
   end

#プロフィール更新
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールを更新しました"
      redirect_to @user
    else
    render 'edit'
  end
  end

  def destroy
 @user = User.find(params[:id])
 @user.destroy
 redirect_to login_url
 end

#ログインしているかを確認
    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
end

 private
 def user_params
  params.require(:user).permit(:userid,:name,:email,:password)
end
end
