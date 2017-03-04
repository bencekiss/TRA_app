class Message < ApplicationRecord
  belongs_to :schedule

  def self.send_message(to, body)
    @client = Twilio::REST::Client.new(Rails.application.secrets.twilio_sid, Rails.application.secrets.twilio_token)
    @twilio_number = "+16479322220"
    @client.account.messages.create(
      from: @twilio_number,
      to: to,
      body: body
    )
  end

  def receive_message
    #what to do when we receive a message
  end


end
