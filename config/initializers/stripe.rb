# Initializes Stripe API object with secret key upon Rails server startup
Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)