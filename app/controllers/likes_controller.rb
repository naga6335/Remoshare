class LikesController < ApplicationController

  before_action :set_like

  def create
    @like = current_user.likes.build(like_params)
    @post = @like.post
    @like.save
    post = Post.find(params[:post_id])
    @post.create_notification_like(current_user)
    respond_to do |format|
      format.html {redirect_to request.referrer}
      format.js
    end
  end


  def destroy
      user = current_user
      post = Post.find(params[:post_id])
      like = Like.find_by(user_id: user.id, post_id: post.id)
      like.delete
  end

  private

  def set_like
      @post = Post.find(params[:post_id])
  end
end
