class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail to: user.email, subject: "Lebron on Skates - password reset"
  end

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Welcome to Lebron on Skates! Please activate your account"
  end
end
