class ReservationMailer < ApplicationMailer
  default from: 'no-reply@wandersportsnc.com' # Set your default sender email here

  def reservation_confirmation(reservation)
    @reservation = reservation
    @customer_email = reservation.email
    mail(to: @customer_email, subject: 'Your Reservation Confirmation')
  end

  def reservation_notification(reservation)
    @reservation = reservation
    mail(to: 'mvineyard@paaimetrics.com', subject: 'New Reservation Received')
  end
end
