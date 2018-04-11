class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :update, :destroy]

  def index
    @activities = Activity.where(trip_id: params[:trip_id])
    render json: @activities
  end

  def show
    render json: @activity
  end

  def create
    destination = Destination.find_or_create_by(destination_params)
    trip = Trip.find_or_create_by(trip_params)
    @activity = Activity.new(activity_params)
    @activity.trip_id = trip.id
    @activity.destination_id = destination.id
    if @activity.save
      render json: @activity
    else
      render json: {errors: @activity.errors.full_messages}, status: 422
    end
  end

  # @trip = Trip.find_or_create_by(trip_id)
  # @user_trip = UserTrip.new(user_trip_params)
  # @user_trip.user_id = user_in_session.id
  # @user_trip.trip_id = @trip.id
  # @user_trip.save
  # render json: {trip: TripSerializer.new(@trip), user_trip: UserTripSerializer.new(@user_trip)}

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
    params.require(:activity).permit(:trip_id, :name, :description, :cost, :start_time, :end_time, :lat, :lng, :address)
  end

  def set_activity
    @activity = Activity.find(params[:id])
  end

  def destination_params
    params.require(:destination).permit(:name, :description, :lat, :lng)
  end

  def trip_params
    params.require(:trip).permit(:name, :description, :duration)
  end
end
