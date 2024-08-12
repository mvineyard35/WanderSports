class ReservationMailer < ApplicationMailer
  default from: 'noreply.wandersportsnc@gmail.com'

  def reservation_confirmation(reservation)
    @reservation = reservation
    mail(to: @reservation.email, subject: 'Your Reservation Confirmation')
  end

  def reservation_notification(reservation)
    @reservation = reservation
    mail(to: 'wandersportsnc@gmail.com', subject: 'New Reservation Notification')
  end

  def payment_confirmation(reservation)
    @reservation = reservation
    mail(to: @reservation.email, subject: 'Payment Confirmation')
  end

  def payment_notification(reservation)
    @reservation = reservation
    mail(to: 'wandersportsnc@gmail.com', subject: 'New Payment Received')
  end
end
