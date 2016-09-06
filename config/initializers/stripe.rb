if Rails.env == 'production'
  Rails.configuration.stripe = {
    :publishable_key => MY_PUBLISHABLE_KEY,
    :secret_key      => MY_SECRET_KEY
  }
else
  Rails.configuration.stripe = {
    :publishable_key => 'pk_test_Ns6tz2pvq3SLoaNI2pVZWh3A',
    :secret_key      => 'sk_test_zZf3eOKN6CWxinISfLjJZ55l'
  }
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]