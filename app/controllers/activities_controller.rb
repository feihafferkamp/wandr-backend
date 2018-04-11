class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :update, :destroy]

  def index
    # on client side, user_trip is just trip
    trip = UserTrip.find(params[:trip_id]).trip
    @activities = Activity.where(trip_id: trip.id)
    render json: @activities
  end

  def show
    render json: @activity
  end

  def create
    destination = Destination.find_or_create_by(destination_params)
    user_trip = UserTrip.find(params[:user_trip][:id])
    trip=user_trip.trip
    @activity = Activity.new(activity_params)
    @activity.trip_id = trip.id
    @activity.destination_id = destination.id
    if @activity.save
      render json: @activity
    else
      render json: {errors: @activity.errors.full_messages}, status: 422
    end
  end

  def update
    if @activity.update(activity_params)
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
    params.require(:activity).permit(:trip_id, :name, :description, :cost, :start_time, :end_time, :lat, :lng, :address)
  end

  def set_activity
    @activity = Activity.find(params[:id])
  end

  def destination_params
    params.require(:destination).permit(:name, :description, :lat, :lng)
  end
end
