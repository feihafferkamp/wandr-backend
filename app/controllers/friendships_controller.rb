class FriendshipsController < ApplicationController
  before_action :set_friend, only: [:create, :update, :cancel, :destroy]

  def index
    @friendships = Friendship.where(user_id: user_in_session.id)
    render json: @friendships
  end

  def create  # when user sends a friend request
    @friendship = Friendship.new(user_id: user_in_session.id, friend_id: @friend.id)
    if @friendship.save
      render json: @friendship
    else
      render json: {errors: @friendship.errors.full_messages}, status: 422
    end
  end

  def update  # when user accepts/rejects a friend request
    invite = Friendship.find_by(user_id: @friend.id, friend_id: user_in_session.id)
    if params[:accept]
      invite.update(accepted: true)
      @friendship = Friendship.create(user_id: user_in_session.id, friend_id: @friend.id, accepted: true)
      render json: @friendship
    else
      invite.destroy
      render json: {message: "Request denied."}
    end
  end

  def cancel
    friendship = Friendship.find_by(user_id: user_in_session.id, friend_id: @friend.id)
    friendship.destroy
    render json: {message: "Your request has been cancelled."}
  end


  def destroy
    friendship_a = Friendship.find_by(user_id: user_in_session.id, friend_id: @friend.id)
    friendship_b = Friendship.find_by(user_id: @friend.id, friend_id: user_in_session.id)
    friendship_a.destroy
    friendship_b.destroy
    render json: {message: "Friendship destroyed."}
  end

  private

  def set_friend
    @friend = User.find_by(id: params[:friend_id])
  end
end
