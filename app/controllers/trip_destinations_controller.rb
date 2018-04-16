class TripDestinationsController < ApplicationController
  before_action :set_trip_destination, only: [:show, :update, :destroy]

  def index
    # @trip_destinations = TripDestination.where(trip_id: trip.id)
    render json: @trip_destinations
  end

  def show
    render json: @trip_destination
  end

  def create
    @trip_destination = TripDestination.new(trip_destination_params)
    if @user_trip.save
      render json: @trip_destination
    else
      render json: {errors: @trip_destination.errors.full_messages}, status: 422
    end
  end


  private

  def trip_destination_params
    params.require(:trip_destination).permit(:trip_id, :destination_id, :arrival, :departure)
  end

  def set_trip_destination
    @trip_destination = TripDestination.find_by(id: params[:id])
  end

end
