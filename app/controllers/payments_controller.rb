class PaymentsController < ApplicationController
  rescue_from Stripe::CardError, with: :catch_exception
  def new
  end

  def create
    binding.pry
    StripeChargesServices.new(payments_params, current_user).call
    @bid = Bid.find_by_id(payments_params[:bid])
    redirect_to bid_award_path(bid)
  end

  def bid_award
    @bid = Bid.find_by_id(params[:payment_id])
    Stripe.api_key = 'sk_test_bRkOf8kxBAex2c0LaES1J4Ry00yOyhM5o7'

session = Stripe::Checkout::Session.create(
  payment_method_types: ['card'],
  submit_type: 'book',
    line_items: [{
      name: "Awarding bid for maintenance request: #{@bid.maintenance_request.title}",
      description: "Company: #{@bid.contractor.company}",
      amount: @bid.price * 100,
      currency: 'usd',
      quantity: 1,
      }],
      success_url: "http://localhost:3000/maintenance_requests/#{@bid.maintenance_request.id}?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: 'http://localhost:3000/maintenance_requests',
    )

    render json: { session_id: session.id }
  end

  def webhook
  binding.pry
  sig_header = Rails.application.credentials.config[:HTTP_STRIPE_SIGNATURE]

  begin
    event = Stripe::Webhook.construct_event(request.body.read, sig_header, Rails.application.credentials.config[:STRIPE_ENDPOINT_SECRET])
  rescue JSON::ParserError
    return head :bad_request
  rescue Stripe::SignatureVerificationError
    return head :bad_request
  end

  webhook_checkout_session_completed(event) if event['type'] == 'checkout.session.completed'

  head :ok
end

private

def build_subscription(stripe_subscription)
    Subscription.new(plan_id: stripe_subscription.plan.id,
                     stripe_id: stripe_subscription.id,
                     current_period_ends_at: Time.zone.at(stripe_subscription.current_period_end))
end

def webhook_checkout_session_completed(event)
  binding.pry
  object = event['data']['object']
  customer = Stripe::Customer.retrieve(object['customer'])
  stripe_subscription = Stripe::Subscription.retrieve(object['subscription'])
  subscription = build_subscription(stripe_subscription)
  user = User.find_by(id: object['client_reference_id'])
  user.subscription.interrupt if user.subscription.present?
  user.update!(stripe_id: customer.id, subscription: subscription)
end

end
