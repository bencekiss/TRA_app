APP_NUMBER = Rails.application.secrets.twilio_num
TWILIO_CLIENT = Twilio::REST::Client.new(Rails.application.secrets.twilio_sid, Rails.application.secrets.twilio_token)
