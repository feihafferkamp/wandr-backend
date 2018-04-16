class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :update, :destroy]

  def index
    @activities = Activity.all
    render json: @activities
  end

  def show
    render json: @activity
  end

  def create
    user_trip = UserTrip.find_by(id: params[:user_trip][:id])
    trip = user_trip.trip
    destination = Destination.find_by(id: params[:destination][:destinationId])
    trip_destination = TripDestination.find_or_create_by(trip_id: trip.id, destination_id: destination.id)
    @activity = Activity.new(activity_params)
    @activity.trip_destination_id = trip_destination.id
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
    params.require(:activity).permit(:name, :description, :cost, :start_time, :end_time, :lat, :lng, :address)
  end

  def set_activity
    @activity = Activity.find_by(id: params[:id])
  end
end
