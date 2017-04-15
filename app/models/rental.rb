class Rental < ApplicationRecord
  has_many :bookings, dependent: :destroy

  validates :daily_rate, numericality: { greather_than_or_equal_to: 0, only_integer: true }
end
