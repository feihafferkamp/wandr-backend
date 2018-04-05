class Destination < ApplicationRecord
  has_many :activities
  has_many :trips, through: :activities
end
