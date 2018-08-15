class FormMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.form_mailer.send_mail.subject
  #
  def send_mail
    @greeting = "Hi"

    mail to: "yosuke.saito1202@gmail.com"
  end
end
