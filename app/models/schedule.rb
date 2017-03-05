class Schedule < ApplicationRecord
  has_many :messages
  belongs_to :account

  def self.send_reminders
    schedules = Schedule.all
    schedules.each do |schedule|

      if Time.now.utc.min == schedule.schedule_time.utc.min

        Message.send_message(schedule.account.phone, schedule.create_primary_template, schedule.id)

      end
      # schedule.messages.each do |message|
      #   diff = Time.now.min.to_i - message.created_at.min.to_i
      #   if message && message.status == 'delivered' && schedule && diff >= 1 && diff < 2
      #     Message.send_message(message.account.phone, schedule.create_primary_rescue, schedule.id)
      #   end
      # end
    end

  end

  def self.send_primary_rescue
    # messages = Message.where("created_at >= ?", Time.zone.now.beginning_of_day-1)
    # messages.each do |message|
    #   schedule = Schedule.find(message.schedule_id)
    #   if message.status == 'delivered' && schedule
    #     #  && (Time.now.hour.to_i - message.created_at.hour.to_i) >= 1
    #     Message.send_message(message.account.phone, schedule.create_primary_rescue, schedule.id)
    #   end
    # end
    # Message.update_old_messages


    Schedule.all.each do |schedule|
      sc_time = schedule.schedule_time.utc.min
      schedule.messages.each do |message|
        diff = Time.now.min.to_i - message.created_at.min.to_i
        ms_time = message.created_at.utc.min
        if message && schedule && ms_time == sc_time && message.status == "delivered" && diff >= 1 && diff < 2
          Message.send_message(message.account.phone, schedule.create_primary_rescue, schedule.id)
          message.update(status: "no_reply")
        end
      end
    end
    # schedule = Schedule.find(message.schedule_id)
    # diff = Time.now.min.to_i - message.created_at.min.to_i


  end

  def self.send_secondary_message
    # messages = Message.where("created_at >= ?", Time.now.utc.beginning_of_day-1)
    # messages.each do |message|
    #   schedule = Schedule.find(message.schedule_id)
    #   if message.status == 'delivered' && (Time.now.min.to_i - message.created_at.min.to_i) >= 2 && schedule
    #     Message.send_message(message.account.secondary_phone, schedule.create_secondary_template, schedule.id)
    #     # Message.send_message(message.account.phone, create_primary_notification, message.schedule.id)
    #   end
    # end
    # Message.update_old_messages

    # message = Message.where("created_at >= ?", Time.zone.now.beginning_of_day-1).order("created_at DESC").first
    # schedule = Schedule.find(message.schedule_id)
    # diff = Time.now.min.to_i - message.created_at.min.to_i
    # if message && message.status == 'delivered' && schedule && diff >= 2 && diff < 3
    #   Message.send_message(message.account.secondary_phone, schedule.create_secondary_template, schedule.id)
    # end
    Schedule.all.each do |schedule|
      sc_time = schedule.schedule_time.utc.min
      schedule.messages.each do |message|
        diff = Time.now.min.to_i - message.created_at.min.to_i
        ms_time = message.created_at.utc.min
        if message && schedule && ms_time == sc_time && message.status == "no_reply" && diff >= 2 && diff < 3
          last_message = schedule.messages.where("created_at > ? AND status = ?", schedule.schedule_time, "delivered").order("created_at DESC").first
          if last_message
            last_message.update(status: "no_reply")
            Message.send_message(message.account.secondary_phone, schedule.create_secondary_template, schedule.id)
            # Message.send_message(message.account.phone, schedule.create_primary_notification, message.schedule.id)
          end
        end
      end
    end
  end

  def self.send_secondary_rescue
    # Message.update_old_messages
    # messages = Message.where("created_at >= ?", Time.now.utc.beginning_of_day-1)
    # messages.each do |message|
    #   if message.status == 'delivered' && (Time.now.hour.to_i - message.created_at.hour.to_i) >= 1
    #     Message.send_message(message.account.secondary_phone, create_secondary_rescue, message.schedule.id)
    #     Message.send_message(message.account.phone, create_primary_notification, message.schedule.id)
    #   end
    # end
    Schedule.all.each do |schedule|
      sc_time = schedule.schedule_time.utc.min
      schedule.messages.each do |message|
        diff = Time.now.min.to_i - message.created_at.min.to_i
        ms_time = message.created_at.utc.min
        if message && schedule && ms_time == sc_time && message.status == "no_reply" && diff >= 3 && diff < 4
          last_message = schedule.messages.where("created_at > ? AND status = ?", schedule.schedule_time, "delivered").order("created_at DESC").first
          if last_message
            last_message.update(status: "no_reply")
            Message.send_message(message.account.secondary_phone, schedule.create_secondary_rescue, message.schedule.id)
          end
        end
      end
    end
  end

  def self.send_emergency_message
    # Message.update_old_messages
    # messages = Message.where("created_at >= ?", Time.now.utc.beginning_of_day-1)
    # messages.each do |message|
    #   if message.status == 'delivered' && (Time.now.hour.to_i - message.created_at.hour.to_i) >= 1
    #     Message.send_message(message.account.emergency_phone, create_emergency_template, message.schedule.id)
    #     Message.send_message(message.account.phone, create_primary_emergency_notification, message.schedule.id)
    #   end
    # end
    Schedule.all.each do |schedule|
      sc_time = schedule.schedule_time.utc.min
      schedule.messages.each do |message|
        # previous = schedule.messages.where("created_at > ? AND status = ?", schedule.schedule_time.min + 3, "delivered").first
        # if schedule.schedule_time + 4
        diff = Time.now.min.to_i - message.created_at.min.to_i
        ms_time = message.created_at.utc.min
        if message && schedule && ms_time == sc_time && message.status == "no_reply" && diff >= 4 && diff < 5
          last_message = schedule.messages.where("created_at > ? AND status = ?", schedule.schedule_time, "delivered").order("created_at DESC").first
          if last_message
            last_message.update(status: "no_reply")
            Message.send_message(message.account.emergency_phone, schedule.create_emergency_template, message.schedule.id)
            # Message.send_message(message.account.phone, schedule.create_primary_emergency_notification, message.schedule.id)
          end
        end
      end
    end
  end

  def create_primary_template
    body = "Hi there #{self.account.name}. Have you checked up on #{self.account.patient_name} recently? Reply YES to confirm. This is an automated message."
    body
  end

  def create_primary_rescue
    body = "Hello again, #{self.account.name}. We haven't heard back from you. Are you ok? Reply YES to confirm. This is an automated message."
    body
  end

  def create_primary_notification
    body = "Hi #{self.account.name}. Because we haven't heard from you, we messaged #{self.account.secondary_name}. Please contact #{self.account.secondary_name} when you get this. This is an automated message."
    body
  end

  def create_primary_emergency_notification
    body = "Hi there #{self.account.name}. Because we haven't heard from you, or #{self.account.secondary_name}, we've notified #{self.account.emergency_name} that there may be an emergency. Please contact #{self.account.emergency_name} as soon as you get this. This is an automated message."
    body
  end

  def create_secondary_template
    body = "Hi #{self.account.secondary_name}. We haven't heard from #{self.account.name} today. Please check on #{self.account.patient_name}. This is an automated message."
    body
  end

  def create_secondary_rescue
    body = "Hello #{self.account.secondary_name}. We haven't heard back from you. Are you ok? Reply YES to confirm, and check on #{self.account.patient_name} as soon as you can. This is an automated message."
    body
  end

  def create_emergency_template
    body = "EMERGENCY: Hi #{self.account.emergency_name}. We haven't heard from #{self.account.patient_name}'s caregiver today. Can you check on #{self.account.patient_name} at #{self.account.patient_address}? Or you can reach them at #{self.account.patient_number}. In case of an emergency please call 911. This is an automated message."
    body
  end

end
