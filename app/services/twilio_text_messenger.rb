class TwilioTextMessenger
  attr_reader :message

  def initialize(message)
    @message = message
  end

  def call
    client = Twilio::REST::Client.new
    client.messages.create({
      from: Rails.application.credentials.twilio_phone_number || ENV['TWILIO_PHONE_NUMBER'],
      to: '+16309017060',
      body: message
    })
  end
end
