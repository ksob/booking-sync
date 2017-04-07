class Booking < ApplicationRecord
  belongs_to :rental

  validate :price_is_valid
  validate :at_least_one_night_stay
  validate :period_do_not_overlap_existing_ones

  scope :overlaping_periods, -> booking {
    where('? >= start_at AND end_at >= ?', booking.end_at, booking.start_at)
  }

  private
    def price_is_valid
      if self.price != (self.end_at.to_date - self.start_at.to_date).to_i * self.rental.daily_rate
        errors.add(:price, "should be valid")
      end
    end

    def at_least_one_night_stay
      if (self.end_at.to_date - self.start_at.to_date).to_i < 1
        errors.add(:duration_of_a_period, "specified by start_at and end_at parameters cannot be less than one night stay")
      end
    end

    def period_do_not_overlap_existing_ones
      overlaps = self.rental.bookings.overlaping_periods(self)
      unless overlaps.empty?
        errors.add(:period, 'specified by start_at and end_at parameters is not available for booking')
      end
    end
end
