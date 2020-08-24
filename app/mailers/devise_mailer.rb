class DeviseMailer < Devise::Mailer

  def unlock_instructions(record, token, opts={})
    @link_to_unlock =
        "https://backend.bumgild.by/unlock?unlock_token=#{token}&email=#{record.email}"
    @text_to_unlock = 'Перейдите по ссылке для разблокировки профиля'
    mail to: record.email,
         from: 'bumgild.mailer@gmail.com',
         subject: 'Бумажная гильдия: инструкция по разблокировке'
  end

end