Rails.configuration.stripe = {
    :stripe_publishable_key => Rails.application.credentials.config[:STRIPE_PUBLISHABLE_KEY],
    :secret_key      => Rails.application.credentials.config[:STRIPE_SECRET_KEY]
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
