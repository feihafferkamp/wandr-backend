class Activity < ApplicationRecord
  belongs_to :trip_destination

  has_many :trips, through: :trip_destination
  has_many :user_trips, through: :trips
  # has_many :destinations, through: :trip_destination
end
