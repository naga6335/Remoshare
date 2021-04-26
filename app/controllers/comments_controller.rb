class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user_id = current_user.id
    @comments = @post.comments.all.includes(:user).order(created_at: :desc)
    @post.create_notification_comment(current_user, @comment.id)
    @comment.save
    render :create
  end

  def destroy
    @comment = Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    render :destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :post_id)
  end
end
