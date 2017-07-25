class Recommendation < ActiveRecord::Base
  validates :content, :rating, :location
  belongs_to :traveler
end
