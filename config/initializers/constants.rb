APP_NUMBER = "+16474960471"
TWILIO_CLIENT = Twilio::REST::Client.new(Rails.application.secrets.twilio_sid, Rails.application.secrets.twilio_token)
