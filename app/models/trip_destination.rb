class TripDestination < ApplicationRecord
  belongs_to :trip
  belongs_to :destination
  has_many :activities
end
