class AuthController < ApplicationController
  def create
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      token = issue_token({user_id: @user.id})
      render json: {user: @user, token: token}
    else
      render json: {error: "Username or password is incorrect."}
    end
  end

  def show
    if current_user
      render json: current_user
    else
      render json: {error: "You must be logged in."}
    end
  end
end
