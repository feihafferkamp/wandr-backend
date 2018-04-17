class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    accepted_invites = user_in_session.friendships.select {|f| f.accepted}
    @friends = accepted_invites.map {|i| i.friend}
    pending_invites = Friendship.where(friend_id: user_in_session.id, accepted: false)
    @pending_friends = pending_invites.map {|i| i.user }
    sent_invites = Friendship.where(user_id: user_in_session.id, accepted: false)
    @requested_friends = sent_invites.map {|i| i.friend}
    @strangers = User.all.select {|u| user_in_session.id != u.id && !@friends.include?(u) && !@pending_friends.include?(u) && !@requested_friends.include?(u)}
    render json: {friends: with_messages(@friends), pending_friends: @pending_friends, requested_friends: @requested_friends, strangers: @strangers}
  end

  def show
    @user = User.find_by(id: params[:id])
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      token = issue_token({user_id: @user.id})
      render json: {user: UserSerializer.new(@user), jwt: token}
    else
      render json: {errors: @user.errors.full_messages}, status: 422
    end
  end

  def update
    if @user.update(params[:user])
      render json: @user
    else
      render json: {error: @user.errors.full_messages}, status: 422
    end
  end

  def destroy
    @user.destroy
    render json: {message: "Account deleted"}
  end

  def add_message
    receiver = User.find_by(id: params[:id])
    if user_in_session && receiver
      message = Message.create(sender: user_in_session, receiver: receiver, content: params[:content])
      UserChannel.broadcast_to(receiver, prepare_message(message))
      # also send back to sender
      render json: prepare_message(message)
    else
      render json: {error: 'Steven: "You dun goofed!"'}
    end
  end

  private
  def user_params
    params.require(:user).permit(:firstname, :lastname, :dob, :hometown, :photo, :username, :password)
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end

	def with_messages(users)
    users.map do |user|
      s_msg = Message.where(sender_id: user.id)
      r_msg = Message.where(receiver_id: user.id)
      {id: user.id, username: user.username, firstname: user.firstname, lastname: user.lastname, dob: user.dob, hometown: user.hometown, sent_messages: s_msg, received_messages: r_msg}
    end
	end

	def prepare_message(message)
    {id: message.id, content: message.content, receiver_id: message.receiver.id, sender_id: message.sender.id, created_at: message.created_at}
	end

end
