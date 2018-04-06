class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :firstname, :lastname, :dob, :hometown, :photo
  has_many :user_trips

  class UserTripSerializer < ActiveModel::Serializer
    attributes :ratings, :travel_age, :start_date, :end_date, :trip_id
  end

end
