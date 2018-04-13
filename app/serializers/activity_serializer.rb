class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :trip_destination_id, :name, :description, :cost, :start_time, :end_time, :lat, :lng, :address, :img

  belongs_to :trip_destination

  has_many :trips, through: :trip_destination
  has_many :user_trips, through: :trips
  # has_many :destinations, through: :trip_destination
end
