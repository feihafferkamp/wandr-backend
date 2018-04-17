class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :firstname, :lastname, :dob, :hometown, :friends

  has_many :user_trips
  has_many :friendships
  has_many :friends, through: :friendships

end
