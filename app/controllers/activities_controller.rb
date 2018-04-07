class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :update, :destroy]

  def index
    @activitys = Activity.all
    render json: @activitys
  end

  def show
    render json: @activity
  end

  def create
    @activity = Activity.new(activity_params)
    if @activity.save
      token = issue_token({activity_id: @activity.id})
      render json: {activity: ActivitySerializer.new(@activity), jwt: token}
    else
      render json: {errors: @activity.errors.full_messages}, status: 422
    end
  end

  def update
    if @activity.update(params[:activity])
      render json: @activity
    else
      render json: {error: @activity.errors.full_messages}, status: 422
    end
  end

  def destroy
    @activity.destroy
    render json: {message: "Activity deleted"}
  end

  private

  def activity_params
    params.require(:activity).permit(:name, :description, :duration)
  end

  def set_activity
    @activity = Activity.find(params[:id])
  end

end
