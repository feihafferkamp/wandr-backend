class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :update, :destroy]

  def index
    @trips = Trip.all
    render json: @trips
  end

  def show
    render json: @trip
  end

  def create
    @trip = Trip.new(trip_params)
    if @trip.save
      render json: @trip
    else
      render json: {errors: @trip.errors.full_messages}, status: 422
    end
  end

  def update
    if @trip.update(params[:trip])
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

  def set_trip
    @trip = Trip.find(params[:id])
  end

end
