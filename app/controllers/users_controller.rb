class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
    accepted_invites = user_in_session.friendships.select {|f| f.accepted}
    @friends = accepted_invites.map {|i| i.friend}
    pending_invites = Friendship.where(friend_id: user_in_session.id, accepted: false)
    @pending_friends = pending_invites.map {|i| i.user }
    sent_invites = Friendship.where(user_id: user_in_session.id, accepted: false)
    @requested_friends = sent_invites.map {|i| i.friend}
    @strangers = @users.select {|u| user_in_session.id != u.id && !@friends.include?(u) && !@pending_friends.include?(u) && !@requested_friends.include?(u)}
    render json: {all: @users, friends: @friends, pending_friends: @pending_friends, requested_friends: @requested_friends, strangers: @strangers}
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

  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :dob, :hometown, :photo, :username, :password)
  end

  def set_user
    @user = User.find_by(id: params[:id])
  end

end
