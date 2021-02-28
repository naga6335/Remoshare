class MessagesController < ApplicationController
  before_action :logged_in_user

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
    @message = Message.new(message_params)
      if @message.save
        redirect_to "/rooms/#{@message.room_id}"
      end
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @message = Message.find(params[:id])
    if current_user.id == @message.user_id
      @message.destroy
    end
    redirect_to "/rooms/#{@message.room_id}"
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :message, :room_id).merge(user_id: current_user.id)
  end
end
