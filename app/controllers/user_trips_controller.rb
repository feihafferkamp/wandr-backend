class UserTripsController < ApplicationController

  def index
    @user_trips = UserTrip.where(user_id: user_in_session.id)
    render json: @user_trips
  end

  def create
    @trip = Trip.find_or_create_by(trip_params)
    @user_trip = UserTrip.find_or_create_by(user_id: user_in_session.id, trip_id: @trip.id)
    render json: @user_trip
  end

  def update
    if @user_trip.update(params[:userTrip])
      render json: @user_trip
    else
      render json: [error: @user_trip.errors.messages]
    end
  end

  def destroy
    @user_trip = UserTrip.find_by(id: params[:id])
    @user_trip.destroy
    render json: {message: "Trip is deleted from your collection."}
  end

  private

  def trip_params
    params.require(:trip).permit(:name, :description, :duration)
  end

  def user_trip_params
    params.require(:user_trip).permit(:ratings, :start_date, :end_date)
  end

end
