class User < ApplicationRecord
  has_many :user_trips
  has_many :trips, through: :user_trips
  validates :username, uniqueness: true, presence:true, length: { minimum: 2 }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, uniqueness: true, presence:true
  validates :password, confirmation: true
  validates :firstname, :lastname, presence: true, length: { maximum: 20 }
  validates :dob, presence: true
  has_secure_password
end
