APP_NUMBER = "+16479322220"
TWILIO_CLIENT = Twilio::REST::Client.new(Rails.application.secrets.twilio_sid, Rails.application.secrets.twilio_token)
