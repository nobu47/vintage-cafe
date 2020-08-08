class PostsController < ApplicationController
  before_action :correct_user, only: [:destroy]
  before_action :require_user_logged_in, only: [:show]
  
  def index
    @posts = Post.order(id: :desc).page(params[:page]).per(5)
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.order(id: :desc).page(params[:page])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    
    if @post.save
      flash[:success] = '正常に投稿されました'
      redirect_to @post
    else
      flash.now[:danger] = '投稿されませんでした'
      render :new
    end
  end

  def destroy
    @post.destroy
    flash[:success] = '投稿を削除しました。'
    redirect_to root_url
  end
  
  private

  def post_params
    params.require(:post).permit(:image)
  rescue ActionController::ParameterMissing
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
  
end
