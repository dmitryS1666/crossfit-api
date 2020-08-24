# frozen_string_literal: true

class UnlockController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :doorkeeper_authorize!
  skip_before_action :verify_authenticity_token

  # GET /resource/unlock/new
  # def new
  #   super
  # end

  # POST /resource/unlock
  # def create
  #   super
  # end

  # GET /resource/unlock?unlock_token=abcdef
  def show
    user = User.find_by(email: params[:email])

    if user.present? && user.unlock_token && user.unlock_token_valid?
      user.unlock_token = nil
      user.failed_attempts = 0
      user.locked_at = nil
      user.save!
      render json: {status: 'ok'}, status: :ok
    else
      render json: {error: 'Link not valid or expired. Try generating a new link.'}, status: :not_found
    end
  end

  # GET /resource/unlock?unlock_token=abcdef&email=user@email.com
  def continue
    user = User.find_by(email: params[:email])

    if user.present? && user.unlock_token && user.unlock_token_valid?
      user.unlock_token = nil
      user.failed_attempts = 0
      user.locked_at = nil
      user.save!
      # GO HOME
      redirect_to "https://bumgild.by/login"
    else
      render json: {error:  'Link not valid or expired. Try generating a new link.'}, status: :not_found
    end
  end

  def unlock_profile
    user = User.find_by(email: params[:email])

    if user.present? && user.unlock_token
      user.send_unlock_instructions_on_demand
      render json: {status: 'Unlock instructions sent to your email'}, status: :ok
    else
      render json: {error:  'User not present in system.'}, status: :not_found
    end
  end

  # protected

  # The path used after sending unlock password instructions
  # def after_sending_unlock_instructions_path_for(resource)
  #   super(resource)
  # end

  # The path used after unlocking the resource
  # def after_unlock_path_for(resource)
  #   super(resource)
  # end
end
