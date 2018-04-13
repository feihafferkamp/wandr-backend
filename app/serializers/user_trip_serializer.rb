class UserTripSerializer < ActiveModel::Serializer
  attributes :id, :trip_id, :user_id, :ratings, :travel_age, :start_date, :end_date, :activities, :destinations

  belongs_to :user
  belongs_to :trip
  has_many :activities
  has_many :destinations

  # def activities
  #   object.trip.activities
  # end
  #
  # def destinations
  #   object.trip.activities
  # end

end
