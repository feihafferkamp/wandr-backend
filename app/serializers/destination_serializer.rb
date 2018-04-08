class DestinationSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :lat, :lng

  has_many :activities
  has_many :activities, through: :destinations
end
