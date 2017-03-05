class Message < ApplicationRecord

  belongs_to :schedule
  has_one :account, through: :schedule

  #sends verification code to new accounts to verify phone numbers
  def self.send_code(account, verification)
    body = "Here is your verification code: " + verification
    self.send_verification(account.phone, body)
  end


  def self.send_verification(to, body, *schedule_id)
    TWILIO_CLIENT.account.messages.create(
      from: APP_NUMBER,
      to: to,
      body: body
    )
    message = Message.create(
      body: body,
      to_number: to,
      from_number: APP_NUMBER,
      status: 'delivered',
      schedule_id: schedule_id
      )

  end

  def self.send_message(to, body, schedule_id)
    TWILIO_CLIENT.account.messages.create(
      from: APP_NUMBER,
      to: to,
      body: body
    )
    message = Message.create(
      body: body,
      to_number: to,
      from_number: APP_NUMBER,
      status: 'delivered',
      schedule_id: schedule_id
      )

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

  def self.update_old_messages
    #updating status of old messages to avoid sending secondary replies to people multiple times. I dunno. Ask Gee.
    sleep 30
    messages = Message.all
    messages.each do |message|
      message_time = message.created_at.hour.to_i
      if (Time.now.utc.hour.to_i - message_time) >= 2
        message.status = "no reply"
        message.save
      end
    end

  end

end
