class FriendshipSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :friend_id, :accepted
  belongs_to :friend
end
