class UserMailer < ApplicationMailer
  before_action :get_headers
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.welcome.subject
  #
  def welcome(user)
    @user = user
    mail(from: 'contact@loxambastia.com',
         to: @user.email,
         subject: 'Bienvenu chez Loxam Bastia!')
  end

  private

  def get_headers
    headers['X-Postmark-Account-Token'] = 'd9d5b157-c617-4500-8195-f4cffde890fd',
  end
end
