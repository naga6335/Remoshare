class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :destroy]

  def index
    @posts = Post.all.includes(:user).order('created_at DESC')
    @user = User.find_by(params[:id])
    @tag_list = Tag.all
  end

  def new
    @post = Post.new
  end

  def show
    @posts = Post.all
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user).order(created_at: :desc)
    @comment = Comment.new
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
    flash[:success] = '投稿を削除しました'
    redirect_to request.referer
  end

  def search
    @tag_list = Tag.all  #こっちの投稿一覧表示ページでも全てのタグを表示するために、タグを全取得
    @tag = Tag.find(params[:tag_id])  #クリックしたタグを取得
    @posts = @tag.posts.all           #クリックしたタグに紐付けられた投稿を全て表示
  end

  private

  def post_params
    params.require(:post).permit(:title, :image, :content, :review)
  end
end
