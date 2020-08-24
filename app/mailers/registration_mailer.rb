class RegistrationMailer < ApplicationMailer
  def start
    @link_to_reg =
      "https://bumgild.by/registration/#{params[:registration].token}"
    mail to: params[:registration].email,
         subject: 'Бумажная гильдия: продолжение регистрации'
  end
end
