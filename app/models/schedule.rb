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

  def create_primary_template
    body = "Hi there #{self.account.name}! Have you seen if #{self.account.patient_name} is doing ok? Reply YES to confirm."
    body
  end

  def create_primary_rescue
    body = "Hi there #{self.account.name}! We haven't heard back from you. Are you ok? Reply YES to confirm."
    body
  end

  def create_secondary_template
    body = "Hi there #{self.account.secondary_name}! Please check on #{self.account.patient_name}. We haven't heard back from #{self.account.name}"
    body
  end

  def create_secondary_rescue
    body = "Hi there #{self.account.secondary_name}! We haven't heard back from you. Are you ok? Reply YES to confirm."
    body
  end

  def create_emergency_template
    body = "Hi there #{self.account.emergency_name}. There's an emergency with #{self.account.patient_name} at #{self.account.patient_address}. You can reach him at #{self.account.patient_number}."
    body
  end

end
