class FriendshipSerializer < ActiveModel::Serializer
  attributes :id, :accepted, :friend_id
  belongs_to :friend, serializer: UserSerializer
end
