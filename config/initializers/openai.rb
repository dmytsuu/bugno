OpenAI.configure do |config|
    config.access_token = Rails.application.credentials.gpt_secret
end