class Activity < ApplicationRecord
  belongs_to :trip_destination
  # belongs_to :destination
  # belongs_to :trip
  # has_many :user_trips, through: :trip
end
