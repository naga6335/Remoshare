class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:succes] = '投稿しました'
      redirect_to request.referer
    else
      flash[:alert] = "入力に誤りがあります"
      redirect_to request.referer
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to request.referer
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end
end
