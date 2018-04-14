class DestinationSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :lat, :lng, :activities

  has_many :trip_destinations
  has_many :activities, through: :trip_destinations

end
