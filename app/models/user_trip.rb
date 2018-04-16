class UserTrip < ApplicationRecord
  belongs_to :user
  belongs_to :trip

  has_many :destinations, through: :trip
end
