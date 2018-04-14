class UserTripSerializer < ActiveModel::Serializer
  attributes :id, :trip_id, :user_id, :ratings, :travel_age, :start_date, :end_date, :destinations

  belongs_to :trip
  has_many :destinations

end
