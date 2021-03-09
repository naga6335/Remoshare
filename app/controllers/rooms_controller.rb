class RoomsController < ApplicationController
  before_action :logged_in_user, only: [:index, :create, :show]

  def create
    @room = Room.create
    Entry.create(room_id: @room.id, user_id: current_user.id)
    Entry.create(room_params)
    redirect_to room_path(@room.id)
  end

  def show
    @user = User.find_by(params[:id])
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages.includes(:user).order("created_at asc")
      @message = Message.new
      @entries = @room.entries.includes(:user)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def room_params
    params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id)
  end

end
