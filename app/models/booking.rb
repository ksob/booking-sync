class Booking < ApplicationRecord
  belongs_to :rental

  validate :price_is_valid

  private
    def price_is_valid
      if self.price != (self.end_at.to_date - self.start_at.to_date).to_i * self.rental.daily_rate
        errors.add(:price, "should be valid")
      end
    end
end
