class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = ENV['STRIPE_WEBHOOK_SECRET']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
    rescue JSON::ParserError => e
      Rails.logger.error("Invalid payload: #{e.message}")
      render json: { error: 'Invalid payload' }, status: 400
      return
    rescue Stripe::SignatureVerificationError => e
      Rails.logger.error("Invalid signature: #{e.message}")
      render json: { error: 'Invalid signature' }, status: 400
      return
    end

    Rails.logger.info("Received webhook event: #{event.inspect}")
    
    if event['type'] == 'checkout.session.completed'
      handle_checkout_session_completed(event['data']['object'])
    else
      Rails.logger.warn("Unhandled event type: #{event['type']}")
    end

    render json: { message: 'Webhook received' }, status: 200
  end

  private

  def handle_checkout_session_completed(session)
    Rails.logger.info("Processing checkout session completed event: #{session.inspect}")

    customer_email = session['customer_details']['email']
    reservation = Reservation.find_by(email: customer_email)

    if reservation
      reservation.update(paid: true)
      Rails.logger.info("Updated reservation for email: #{customer_email}")
      ReservationMailer.payment_confirmation(reservation).deliver_now
      ReservationMailer.payment_notification(reservation).deliver_now
    else
      Rails.logger.warn("No reservation found for email: #{customer_email}")
    end
  end
end

private

def handle_checkout_session_completed(session)
  Rails.logger.info("Processing checkout session completed event: #{session.inspect}")

  customer_email = session['customer_details']['email']
  reservation = Reservation.find_by(email: customer_email)

  if reservation
    reservation.update(paid: true)
    Rails.logger.info("Updated reservation for email: #{customer_email}")
    
    # Send payment confirmation to the customer
    ReservationMailer.payment_confirmation(reservation).deliver_later
    
    # Send payment notification to yourself
    ReservationMailer.payment_notification(reservation).deliver_later
  else
    Rails.logger.warn("No reservation found for email: #{customer_email}")
  end
end
