class LikesController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
    like = current_user.likes.build(post_id: params[:post_id])
    like.save
    # redirect_to request.referer
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
    like.destroy
    # redirect_to request.referer
  end

  # private

  # def post_params
  #   @post = Post.find(params[:post_id])
  # end
end
