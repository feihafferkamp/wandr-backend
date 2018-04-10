class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find_by(id: params[:id])
    render json: UserSerializer.new(@user)
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
      render json: UserSerializer.new(@user)
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
    @user = User.find(params[:id])
  end

end
