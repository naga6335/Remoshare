class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :edit, :destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment_post = @comment.post
    if @comment.save
      flash[:succes] = '投稿しました'
      @comment_post.create_notification_comment(current_user, @comment.id)
      redirect_to request.referer
    else
      flash[:alert] = "入力に誤りがあります"
      redirect_to request.referer
    end
  end

  def destroy
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    redirect_to request.referer
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :notification)
  end
end
