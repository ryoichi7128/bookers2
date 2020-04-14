class UsersController < ApplicationController

before_action :authenticate_user!, only: [:index, :show, :edit, :update]


# マイページ用
  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end


  def index
    # 全てユーザー表示用の変数
    @users = User.all
    # プロフィール用の変数
    @user = User.find(current_user.id)
    # 新規投稿用の変数
    @book = Book.new
  end

  # マイページ編集用
  def edit
       @user = User.find(params[:id])
    if current_user != @user
       redirect_to user_path(current_user)
    end
  end

  def update
       @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:notice] = "successfully"
       redirect_to user_path(current_user)
    else
       render action: :edit
    end
  end

private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end


end
