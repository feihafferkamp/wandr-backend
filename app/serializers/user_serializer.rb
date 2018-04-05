class UserSerializer < ActiveModel::Serializer
  attributes :id, :firstname, :lastname, :dob, :hometown, :photo, :username
end
