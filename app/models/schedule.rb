class Schedule < ApplicationRecord
  has_many :messages
  belongs_to :account

  def self.send_reminders
    schedules = Schedule.all
    schedules.each do |schedule|
      if Time.now.hour.utc == schedule.schedule_time.hour
        Message.send_message(schedule.account.phone, create_primary_template)
      end
    end
  end

  def self.send_second_message
    messages = Message.all
    messages.each do |message|
      if message.status == 'delivered' && (Time.now.utc.hour - message.created_at) > 1
        Message.send_message(message.account.phone, create_primary_rescue)
      end
    end
  end


end
