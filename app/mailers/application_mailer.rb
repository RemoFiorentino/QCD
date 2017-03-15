class ApplicationMailer < ActionMailer::Base
  default from: " qcd.mailer.no.reply@gmail.com"
  layout 'mailer'
end
