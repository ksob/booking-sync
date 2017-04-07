class Rental < ApplicationRecord
  has_many :bookings, dependent: :destroy
end
