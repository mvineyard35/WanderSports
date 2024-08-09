class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def stripe
    # Verify webhook signature for security
    payload = request.body.read
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    endpoint_secret = ENV['STRIPE_WEBHOOK_SECRET']

    # Initialize Stripe event variable
    event = nil

    begin
      # Verify webhook signature using Stripe's library
      event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
    rescue JSON::ParserError => e
      # Handle invalid payload
      render json: { error: 'Invalid payload' }, status: 400
      return
    rescue Stripe::SignatureVerificationError => e
      # Handle invalid signature
      render json: { error: 'Invalid signature' }, status: 400
      return
    end

    # Handle successful payment event
    if event['type'] == 'checkout.session.completed'
      handle_checkout_session_completed(event['data']['object'])
    end

    # Respond with 200 status for successful processing
    render json: { message: 'Webhook received' }, status: 200
  end

  private

  # Handle checkout session completion event
  def handle_checkout_session_completed(session)
    # Retrieve customer email from session
    customer_email = session['customer_details']['email']

    # Find the reservation by customer email
    reservation = Reservation.find_by(email: customer_email)

    if reservation
      # Mark the reservation as paid
      reservation.update(paid: true)

      # (Optional) Send a confirmation email to the customer
      # ReservationMailer.confirmation(reservation).deliver_now
    end
  end
end
