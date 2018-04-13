class UserTripsController < ApplicationController
  before_action :set_user_trip, only: [:show, :update, :destroy]

  def index
    @user_trips = UserTrip.where(user_id: user_in_session.id)
    render json: @user_trips
  end

  def show
    render json: @user_trip
  end

  def create
    @user_trip = UserTrip.new(user_trip_params)
    trip = Trip.find_or_create_by(trip_params)
    @user_trip.trip_id = trip.id
    @user_trip.user_id = user_in_session.id
    destinations = params[:destinations].map { |d| Destination.find_or_create_by(name: d['name'], lat: d['lat'], lng: d['lng'])}
    destinations.each {|d| TripDestination.create(trip_id: trip.id, destination_id: d.id)}
    if @user_trip.save
      render json: @user_trip
    else
      render json: {errors: @user_trip.errors.full_messages}, status: 422
    end
  end

  def update
    trip = Trip.find(@user_trip.trip_id)
    trip.update(trip_params)
    trip.destinations.clear
    newDestinations = params[:destinations].map { |d| Destination.find_or_create_by(name: d['name'], lat: d['lat'], lng: d['lng'])}
    newDestinations.each {|nd| TripDestination.create(trip_id: trip.id, destination_id: nd.id)}
    if @user_trip.update(user_trip_params)
      render json: @user_trip
    else
      render json: {error: @user_trip.errors.messages + ' & ' + @trip.errors.mesasges}
    end
  end

  def destroy
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

  def set_user_trip
    @user_trip = UserTrip.find(params[:id])
  end

end
