class TripDestinationSerializer < ActiveModel::Serializer
  attributes :id, :trip_id, :destination_id, :arrival, :departure

  belongs_to :trip
  belongs_to :destination
  has_many :activities

end
