class TripSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :duration

  has_many :user_trips
  has_many :users, through: :user_trips

  has_many :activities
  has_many :destinations, through: :activities
end
