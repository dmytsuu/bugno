class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.credentials.mail_service_user
  layout 'mailer'
end
