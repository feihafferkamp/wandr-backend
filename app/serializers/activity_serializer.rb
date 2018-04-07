class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :cost, :start_time, :end_time, :lat, :lng, :img

  has_one :trip
  has_one :destination
end
