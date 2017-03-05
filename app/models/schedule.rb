class Schedule < ApplicationRecord
  has_many :messages
  belongs_to :account



  def self.send_reminders
    schedules = Schedule.all
    schedules.each do |schedule|
      if Time.now.utc.hour == schedule.schedule_time.hour
        Message.send_message(schedule.account.phone, schedule.create_primary_template, schedule.id)
      end
    end
  end

  def self.send_second_message
    Message.update_old_messages
    messages = Message.where("created_at >= ?", Time.zone.now.beginning_of_day-1)
    messages.each do |message|
      if message.status == 'delivered' && (Time.now.utc.hour - message.created_at.hour) >= 1
        Message.send_message(message.account.phone, create_primary_rescue, message.schedule.id)
      end
    end
  end

  def self.send_secondary_message
    Message.update_old_messages
    messages = Message.where("created_at >= ?", Time.zone.now.beginning_of_day-1)
    messages.each do |message|
      if message.status == 'delivered' && (Time.now.utc.hour - message.created_at.hour) >= 1
        Message.send_message(message.account.secondary_phone, create_secondary_template, message.schedule.id)
        Message.send_message(message.account.phone, create_primary_notification, message.schedule.id)
      end
    end
  end

  def self.send_secondary_rescue
    Message.update_old_messages
    messages = Message.where("created_at >= ?", Time.zone.now.beginning_of_day-1)
    messages.each do |message|
      if message.status == 'delivered' && (Time.now.utc.hour - message.created_at.hour) >= 1
        Message.send_message(message.account.secondary_phone, create_secondary_rescue, message.schedule.id)
        Message.send_message(message.account.phone, create_primary_notification, message.schedule.id)
      end
    end
  end

  def self.send_emergency_message
    Message.update_old_messages
    messages = Message.where("created_at >= ?", Time.zone.now.beginning_of_day-1)
    messages.each do |message|
      if message.status == 'delivered' && (Time.now.utc.hour - message.created_at.hour) >= 1
        Message.send_message(message.account.emergency_phone, create_emergency_template, message.schedule.id)
        Message.send_message(message.account.phone, create_primary_emergency_notification, message.schedule.id)
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

  def create_primary_notification
    body = "Hi there #{self.account.name}! Because we haven't heard from you, we've messaged #{self.account.secondary_name}. Upon
    recieving this message please contact #{self.account.secondary_name}!"
    body
  end

  def create_primary_emergency_notification
    body = "Hi there #{self.account.name}! Because we haven't heard from you, or #{self.account.secondary_name}, we've contacted #{self.account.emergency_name}!
    Upon recieving this message please contact #{self.account.emergency_name}!"
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
