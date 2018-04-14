class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :firstname, :lastname, :dob, :hometown, :photo

  has_many :user_trips
end
