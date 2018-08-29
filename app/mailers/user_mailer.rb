class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #    mail.headers['X-Postmark-Account-Token'] = 'd9d5b157-c617-4500-8195-f4cffde890fd'

  def welcome(user)
    @user = user
    mail(headers = {
                      'X-Postmark-Account-Token' = 'd9d5b157-c617-4500-8195-f4cffde890fd'
                    }
                    from: 'contact@loxambastia.com',
                    to: @user.email,
                    subject: 'Bienvenu chez Loxam Bastia!')
  end
end
