# frozen_string_literal: true

class Api::V1::ConfirmationsController < Devise::ConfirmationsController
  skip_before_action :doorkeeper_authorize!

  respond_to :json

  # GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    if resource.errors.empty?
      Account.create(user_id: resource.id)
      render json: resource.as_json(only: %i[id email confirmed_at]),
             status: :ok
    else
      render json: resource.errors, status: :unprocessable_entity
    end
  end
end
