class UserTripsController < ApplicationController
  before_action :set_user_trip, only: [:show, :update, :destroy]

  def index
    @user_trips = UserTrip.where(user_id: user_in_session.id)
    render json: @user_trips
  end

  def show
    @trip = Trip.find(@user_trip.trip_id)
    render json: {trip: TripSerializer.new(@trip), user_trip: UserTripSerializer.new(@user_trip)}
  end

  def create
    @user_trip = UserTrip.new(user_trip_params)
    if @user_trip.save
      render json: @user_trip
    else
      render json: {errors: @trip.errors.full_messages}, status: 422
    end
  end

  def update
    @trip = Trip.find(@user_trip.trip_id)
    if @user_trip.update(user_trip_params) && @trip.update(trip_params)
      render json: {trip: TripSerializer.new(@trip), user_trip: UserTripSerializer.new(@user_trip)}
    else
      render json: {error: @user_trip.errors.messages + ' & ' + @trip.errors.mesasges}
    end
  end

  def destroy
    @user_trip.destroy
    render json: {message: "Trip is deleted from your collection."}
  end

  private

  def user_trip_params
    params.require(:user_trip).permit(:ratings, :start_date, :end_date)
  end

  def set_user_trip
    @user_trip = UserTrip.find(params[:id])
  end

end
