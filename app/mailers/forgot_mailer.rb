class ForgotMailer < ApplicationMailer
  def start
    @link_to_forgot =
      "https://bumgild.by/password-reset/#{params[:user].reset_password_token}"
    mail to: params[:user].email,
         subject: 'Бумажная гильдия: восстановление пароля'
  end
end
