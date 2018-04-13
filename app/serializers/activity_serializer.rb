class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :trip_destination_id, :name, :description, :cost, :start_time, :end_time, :lat, :lng, :address, :img

  belongs_to :trip_destination
end
