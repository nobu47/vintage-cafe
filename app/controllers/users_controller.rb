class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :likes]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザ情報を変更しました。"
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザ情報の変更に失敗しました。'
      render :edit
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザ登録を削除しました"
    redirect_to root_url
  end
  
  def likes
    @user = User.find(params[:id])
    @likes = @user.likes.order(id: :desc).page(params[:page])
    counts(@user)
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def correct_user
    @user = User.find(params[:id])
    redirect_to(@user) unless current_user?(@user)
  end
  
end
