Rails.configuration.stripe = {
    :publishable_key => ENV['PUBLISHABLE_KEY'], #TODO: Actually set these locally
    :secret_key      => ENV['SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]