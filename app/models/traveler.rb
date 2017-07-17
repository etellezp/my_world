class Traveler < ActiveRecord::Base
  has_secure_password
  has_many :recommendations
  validates :username, :email, presence: true
end
