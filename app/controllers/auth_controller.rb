class AuthController < ApplicationController

  def create
    @user = User.find_by(username: params[:user][:username])
    if @user && @user.authenticate(params[:user][:password])
      token = issue_token({user_id: @user.id})
      render json: {user: UserSerializer.new(@user), jwt: token}
    else
      render json: {error: "Username or password is incorrect."}
    end
  end

  def show
    if user_in_session
      render json: user_in_session
    else
      render json: {error: "You must be logged in."}
    end
  end
end
