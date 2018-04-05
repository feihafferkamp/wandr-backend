class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create]

  # def index
  #   if params[:name]
  #     @user = User.find_by(username: params[:name])
  #     render json: @user
  #   else
  #     @users = User.all
  #     render json: current_user
  #   end
  # end
  #
  # def show
  #   @user = User.find_by(id: params[:id])
  #   render json: @user
  # end

  def create
    @user = User.new(user_params)
    if @user.save
      token = issue_token({user_id: @user.id})
      render json: {user: UserSerializer.new(@user), jwt: token}
    end
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :dob, :hometown, :photo, :username, :password)
  end

end
