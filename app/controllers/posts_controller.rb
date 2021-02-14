class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :destroy]
  before_action :correct,        only: [:destroy]
  def index
    @posts = Post.all.includes(:user).order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "投稿しました！"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    post.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to request.referrer || root_url
  end

  private

  def post_params
    params.require(:post).permit(:content, :image)
  end

  def correct
    post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end
end
