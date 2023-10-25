require 'line/bot'
LINE_BOT_CLIENT = Line::Bot::Client.new do |config|
  config.channel_id = Rails.application.credentials.channel_id
  config.channel_secret = Rails.application.credentials.channel_secret
  config.channel_token = Rails.application.credentials.channel_token
end