class TripSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :duration
  has_many :user_trips
  has_many :activities

  class UserTripSerializer < ActiveModel::Serializer
    attributes :user_id, :ratings, :travel_age
  end

  class ActivitySerializer < ActiveModel::Serializer
    attributes :id, :name, :description, :cost, :start_time, :end_time, :lat, :lng, :img, :destination_id
  end

end
