# app/models/reservation.rb
class Reservation < ApplicationRecord
  # Other model code...
  validate :start_date_cannot_be_in_the_past

  private

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, "Date can't be in the past")
    end
  end
  
end
