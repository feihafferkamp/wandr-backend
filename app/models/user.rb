class User < ApplicationRecord
  has_many :user_trips
  has_many :trips, through: :user_trips
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :messages
  
  validates :username, uniqueness: true, presence: true, length: { minimum: 2 }
  validates :password, confirmation: true
  validates :firstname, :lastname, :dob, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, uniqueness: true, presence:true
  has_secure_password

end
