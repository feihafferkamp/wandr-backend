class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :trip_id, :destination_id, :name, :description, :cost, :start_time, :end_time, :lat, :lng, :address, :img

  belongs_to :trip
  belongs_to :destination
end
