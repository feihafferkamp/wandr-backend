class Trip < ApplicationRecord
  has_many :user_trips
  has_many :users, through: :user_trips

  has_many :trip_destinations
  has_many :activities, through: :trip_destinations
  has_many :destinations, through: :trip_destinations

end
