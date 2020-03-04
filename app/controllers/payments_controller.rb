class PaymentsController < ApplicationController
  rescue_from Stripe::CardError, with: :catch_exception
  def new
  end

  def create
    StripeChargesServices.new(payments_params, current_user).call
    @bid = Bid.find_by_id(payments_params[:bid])
    redirect_to bid_award_path(bid)
  end

  def bid_award
    @bid = Bid.find_by_id(params[:payment_id])
    Stripe.api_key = ENV['STRIPE_SECRET_KEY']
    session = Stripe::Checkout::Session.create(
    payment_method_types: ['card'],
    customer_email: current_user.email,
    submit_type: 'book',
    line_items: [{
      name: "Awarding bid for maintenance request: #{@bid.maintenance_request.title}",
      description: "Company: #{@bid.contractor.company}",
      amount: @bid.price * 100,
      currency: 'usd',
      quantity: 1,
      }],
      payment_intent_data: {
    capture_method: 'manual',
    application_fee_amount: @bid.price * 10,
    transfer_data: {
      destination: "#{@bid.contractor.stripe_uid}",
      },
      },
        metadata: {
          bid: @bid.id
        },
      client_reference_id: current_user.id,
      success_url: "http://localhost:3000/maintenance_requests/#{@bid.maintenance_request.id}?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: 'http://localhost:3000/maintenance_requests',
    )

    render json: { session_id: session.id }
  end

  def webhook
  sig_header = request.env['HTTP_STRIPE_SIGNATURE']

  begin
    creds = Rails.application.credentials.config[:STRIPE_ENDPOINT_SECRET]
    event = Stripe::Webhook.construct_event(request.body.read, sig_header, creds)
  rescue JSON::ParserError
    return head :bad_request
  rescue Stripe::SignatureVerificationError
    return head :bad_request
  end

  webhook_checkout_session_completed(event) if event['type'] == 'checkout.session.completed'

  head :ok
end

private

def webhook_checkout_session_completed(event)
  object = event['data']['object']
  customer = Stripe::Customer.retrieve(object['customer'])
  user = User.find_by(id: object['client_reference_id'])
  user.update!(stripe_uid: customer.id)
## award bid
  @bid = Bid.find_by_id(event['data']['object']['metadata']['bid'])
  if @bid.approved?
    @bid.update_attribute(:approved, false)
  else
    @bid.update_attribute(:approved, true)
    @bid.update_attribute(:payment_intent, event['data']['object']['payment_intent'])
    @bid.maintenance_request.contractor_id = @bid.contractor_id
    @bid.maintenance_request.save
    UserMailer.with(bid: @bid, contractor: @bid.contractor).contractor_award_notification.deliver_now
  end
end
end
