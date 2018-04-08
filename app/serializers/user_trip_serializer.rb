class UserTripSerializer < ActiveModel::Serializer
  attributes :id, :trip_id, :user_id, :ratings, :travel_age, :start_date, :end_date

  belongs_to :user
  belongs_to :trip
end
