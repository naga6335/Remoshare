class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :destroy]

  def index
    @posts = Post.all.includes(:user, :tags, :tagmaps, :likes).order(created_at: :desc).search(params[:search]).page(params[:page]).per(8)
    @user = User.find_by(params[:id])
    @ranks = Post.includes(:user).create_all_ranks
    @tag_list = Tag.all.includes(:posts)
  end

  def new
    @post = Post.new
  end

  def show
    @posts = Post.all
    @post = Post.find(params[:id])
    @user = User.find_by(params[:id])
    @comment = Comment.new
    @comments = @post.comments.all.includes(:user).order(created_at: :desc)
    @post_tags = @post.tags
  end

  def create
    @post = current_user.posts.new(post_params)
    tag_list = params[:post][:tag_name].split(nil)
    if @post.save
      @post.save_tag(tag_list)
      flash[:success] = "投稿しました！"
      redirect_to root_url
    else
      flash.now[:alert] = "入力に誤りがあります"
      render 'new'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "投稿を更新しました"
      redirect_to root_url
    else
      flash.now[:alert] = "入力に誤りがあります"
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = '投稿を削除しました'
    redirect_to request.referer
  end

  def search
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.all.includes(:user, :tags, :tagmaps, :likes)
  end

  private

  def post_params
    params.require(:post).permit(:title, :image, :content, :price, :issue)
  end
end
