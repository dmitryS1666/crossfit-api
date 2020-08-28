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

      Rails.logger.warn 'PARAMS: '
      Rails.logger.warn params

      # Telegram::Bot::Client.run(
      #   '717496038:AAHHW4wqViXT_EIrBpjdJzzjrFLUev8SjOI'
      # ) do |bot|
      #   bot.api.send_message(chat_id: '454126028', text: registration.to_json)
      # end

      user = User.new(email: params[:email], password: params[:password])
      user.first_name = params[:first_name]
      user.last_name = params[:last_name]
      user.phone = params[:phone]
      user.birthDate = params[:birthDate]
      user.sex = params[:sex]
      user.height = params[:height]
      user.weight = params[:weight]
      user.duration = params[:duration]
      user.visits = params[:visits]
      user.price = params[:price]
      user.ticketId = params[:ticketId]

      if params[:client]
        user.purchaseTime = params[:purchaseTime]
        user.backSquat = params[:backSquat]
        user.frontSquat = params[:frontSquat]
        user.clean_and_jerk = params[:clean_and_jerk]
        user.snatch = params[:snatch]
        user.benchPress = params[:benchPress]
        user.deadlift = params[:deadlift]
        user.subscriptions = params[:subscriptions]
        user.subscriptionId = params[:subscriptionId]
        user.trainerId = params[:trainerId]
        user.attendanceTime = params[:attendanceTime]
        user.trainingId = params[:trainingId]
      elsif params[:trainer]
        user.tickets = params[:tickets]
        user.club = params[:club]
        user.description = params[:description]
        user.attendances = params[:attendances]
        user.subscriptions = params[:subscriptions]
      else
        render plain: { hello: 'Fields trainer or client cannot be empty' }.to_json,
               content_type: 'application/json'
        return
      end

      user.save
      render plain: { hello: 'Complete registration on Service' }.to_json,
             content_type: 'application/json'
      return
    else
      render plain: {  message: 'User exist' }.to_json,
             content_type: 'application/json'
      return
    end
  end
end
