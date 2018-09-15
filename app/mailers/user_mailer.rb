class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user
    mail(from: 'contact@loxambastia.com',
         to: @user.email,
         subject: 'Bienvenue chez Loxam Bastia!')
  end
end
