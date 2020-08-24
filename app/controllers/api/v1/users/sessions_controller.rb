# frozen_string_literal: true

class Api::V1::Users::SessionsController < Devise::SessionsController
  # skip_before_action :doorkeeper_authorize!

  # def create
  #   user = User.find_by_email(params[:email])
  #   if user&.user.valid_password?(params[:password])
  #     render json: user.as_json(only: [:id, :email, :authentication_token]), status: :created
  #   else
  #     head(:unauthorized)
  #     # render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
  #   end
  # end

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
