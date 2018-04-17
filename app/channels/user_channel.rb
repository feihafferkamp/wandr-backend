class UserChannel < ApplicationCable::Channel
  def subscribed
    user = User.find_by(id: params[:user_id])
    stream_for user
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
