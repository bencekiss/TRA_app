class Message < ApplicationRecord

  belongs_to :schedule
  has_one :account, through: :schedule

  def self.send_message(to, body, schedule_id)
    @client = Twilio::REST::Client.new(Rails.application.secrets.twilio_sid, Rails.application.secrets.twilio_token)
    @twilio_number = "+16479322220"
    @client.account.messages.create(
      from: @twilio_number,
      to: to,
      body: body
    )

    message = Message.create({
      body: body,
      to_number: to,
      from_number: @twilio_number,
      status: 'delivered',
      schedule_id: schedule_id
      })

  end

  def self.receive_message(params, message_to_change, schedule_id)

    message = Message.create({
      body: params[:Body],
      to_number: params[:To],
      from_number: params[:From],
      status: 'received',
      schedule_id: schedule_id
      })
    message
    #save message to table with status "received"

    #change status of most recent message TO that same phone number to "replied"
    message_to_change.update(status: "replied")

  end

  def update_old_messages
    #updating status of old messages to avoid sending secondary replies to people multiple times. I dunno. Ask Gee.
    messages = Message.all
    messages.each do |message|
      if Time.now.utc.hour - message.created_at.hour >= 2
        message.status = "no reply"
        message.save
      end
    end

  end

end
