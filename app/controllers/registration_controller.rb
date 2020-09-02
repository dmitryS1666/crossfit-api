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
      return
    end

    return render json: { message: 'Incorrect password length. Range from 4 to 8 values' } if params[:password].length < 4 || params[:password].length > 8

    if params[:password] != params[:password_confirmation]
      render json: { message: 'Password and confirm password do not match' }
      return
    else
      @registration = Registration.find_or_create_by(email: email)
      completed(@registration.token)
      # RegistrationMailer.with(registration: @registration).start.deliver_now
    end
  end

  # def continue
  #   params.permit!
  #   reg = Registration.find_by(token: params[:token])
  #   if reg.present?
  #     if User.find_by_email(reg.email).blank?
  #       render json: { email: reg.email }
  #     else
  #       render json: { message: 'User exist' }
  #     end
  #   else
  #     render json: { email: '' }
  #   end
  # end

  def completed(token)
    params.permit!
    registration = Registration.find_by(token: token)

    if registration.present? && User.find_by(email: registration.email).blank?
      registration.name = params[:full_name]
      registration.first_name = params[:first_name]
      registration.last_name = params[:last_name]
      registration.phone = params[:phone]
      registration.password = params[:password]
      registration.complete = true
      registration.save

      if !params[:client].present? && !params[:trainer].present?
        render json: { message: 'Fields trainer or client cannot be empty' }
        return
      end

      # Telegram::Bot::Client.run(
      #   '717496038:AAHHW4wqViXT_EIrBpjdJzzjrFLUev8SjOI'
      # ) do |bot|
      #   bot.api.send_message(chat_id: '454126028', text: registration.to_json)
      # end

      user = User.new(email: params[:email], password: params[:password])
      user.first_name = params[:first_name]
      user.last_name = params[:last_name]
      user.phone = params[:phone]

      user.save
      render json: { message: 'Complete registration on Service', user_id: user.id }
      return
    else
      render json: { message: 'User exist' }
      return
    end
  end
end
