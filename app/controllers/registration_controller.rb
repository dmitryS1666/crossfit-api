class RegistrationController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :doorkeeper_authorize!
  skip_before_action :verify_authenticity_token

  respond_to :json

  def start
    params.permit!
    email = params[:email]
    if User.find_by_email(email).present?
      render json: { message: 'User exist' }
    else
      @registration = Registration.find_or_create_by(email: email)
      completed(@registration.token)
      # RegistrationMailer.with(registration: @registration).start.deliver_now
    end
  end

  def continue
    params.permit!
    reg = Registration.find_by(token: params[:token])
    if reg.present?
      if User.find_by_email(reg.email).blank?
        render json: { email: reg.email }
      else
        render json: { message: 'User exist' }
      end
    else
      render json: { email: '' }
    end
  end

  def completed(token)
    params.permit!
    registration = Registration.find_by(token: token)

    Rails.logger.warn registration

    if registration.present? && User.find_by(email: registration.email).blank?
      registration.name = params[:full_name]
      registration.company = params[:company]
      registration.organization = params[:organization]
      registration.first_name = params[:first_name]
      registration.last_name = params[:last_name]
      registration.unp = params[:unp]
      registration.phone = params[:phone]
      registration.password = params[:password]
      registration.complete = true
      registration.save

      # Telegram::Bot::Client.run(
      #   '717496038:AAHHW4wqViXT_EIrBpjdJzzjrFLUev8SjOI'
      # ) do |bot|
      #   bot.api.send_message(chat_id: '454126028', text: registration.to_json)
      # end

      user =
        User.new(email: registration.email, password: registration.password)
        user.organization = registration.organization
        user.first_name = registration.first_name
        user.last_name = registration.last_name
        user.phone = registration.phone
        user.unp = registration.unp
        user.save
      render plain: { hello: 'Complite registration on Service' }.to_json,
             content_type: 'application/json'
    else
      render plain: {  message: 'User exist' }.to_json,
      content_type: 'application/json'
    end
  end
end
