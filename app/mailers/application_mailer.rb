class ApplicationMailer < ActionMailer::Base
  default from: "Express Line Services <#{ENV['MAIL_FROM']}>"
  layout "mailer"
end
