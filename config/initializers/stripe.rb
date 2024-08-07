# config/initializers/stripe.rb
Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)
Stripe.api_key = ENV['sk_test_51PehJzRxaCSIOTYq4foOyBBZ6SFN5wVDEcqtQla5HcZ0H929eZoTqxYRpZWfDlhJLWumFWa5gFGfatrJsrFvokUP00Z6I48nSq']