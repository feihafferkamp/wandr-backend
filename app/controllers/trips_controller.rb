class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :update, :destroy]

  def index
    @trips = Trip.all
    render json: @trips
  end

  def show
    @user_trip = @trip.user_trips.where(user_id: user_in_session.id)[0]
    render json: {trip: TripSerializer.new(@trip), user_trip: @user_trip}
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      @user_trip = UserTrip.new(user_trip_params)
      @user_trip.user_id = user_in_session.id
      @user_trip.trip_id = @trip.id
      @user_trip.save
      render json: {trip: TripSerializer.new(@trip), user_trip: UserTripSerializer.new(@user_trip)}
    else
      render json: {errors: @trip.errors.full_messages}, status: 422
    end
  end

  def update
    if @trip.update(trip_params)
      render json: @trip
    else
      render json: {error: @trip.errors.full_messages}, status: 422
    end
  end

  def destroy
    @trip.destroy
    render json: {message: "Trip deleted"}
  end

  private

  def trip_params
    params.require(:trip).permit(:name, :description, :duration)
  end

  def user_trip_params
    params.require(:user_trip).permit(:ratings, :start_date, :end_date)
  end

  def set_trip
    @trip = Trip.find(params[:id])
  end

end
