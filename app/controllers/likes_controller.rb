class LikesController < ApplicationController
  before_action :post_params

  def create
    Like.create(user_id: current_user.id, post_id: params[:id])
  end

  def destroy
    Like.find_by(user_id: current_user.id, post_id: params[:id]).destroy
  end

  def post_params
    @post = Post.find(params[:id])
  end

end
