require 'sidekiq'
require 'sidekiq/web'

SIDEKIQ_DEV_USERNAME = 'admin'
SIDEKIQ_DEV_PASSWORD = 'admin'

Sidekiq::Web.use Rack::Auth::Basic, 'You should not be here, punk' do |username, password|
  Rack::Utils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(Rails.env.development? ? SIDEKIQ_DEV_USERNAME : Rails.application.credentials.sidekiq_username)) &
    Rack::Utils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(Rails.env.development? ? SIDEKIQ_DEV_PASSWORD : Rails.application.credentials.sidekiq_password))
end
