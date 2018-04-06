class DestinationSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :lat, :lng
  has_many :activities

  class ActivitySerializer < ActiveModel::Serializer
    attributes :id, :name, :description, :cost, :start_time, :end_time, :lat, :lng, :img, :trip_id
  end

end
