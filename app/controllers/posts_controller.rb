class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :destroy]

  def index
    @posts = Post.all.includes(:user).order('created_at DESC')
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = @post.comments.includes(:user).order(created_at: :desc)
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "投稿しました！"
      redirect_to root_url
    else
      flash[:alert] = "入力に誤りがあります"
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "更新しました！"
      redirect_to root_url
    else
      flash[:alert] = "入力に誤りがあります"
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_url
  end

  private

  def post_params
    params.require(:post).permit(:content, :image)
  end
end
