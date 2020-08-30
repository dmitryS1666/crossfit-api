class Api::V1::UsersController < ApplicationController
  # skip_before_action :doorkeeper_authorize!
  before_action :authorize_user_policy, only: %i[create update destroy all_users]
  before_action :load_user, only: %i[show edit update]

  def all_users
    render json: serialize_users(User.all)
  end

  def update
    if @user.update(user_params)
      @user.save
      render plain: {
          id: @user.id,
          email: @user.email,
          first_name: @user.first_name,
          last_name: @user.last_name,
          phone: @user.phone
      }.to_json,
             status: 200,
             content_type: 'application/json'
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def authorize_user_policy
    authorize current_user, policy_class: UserPolicy
  end

  def user_params
    params.require(:user).permit(
        :first_name,
        :last_name,
        :phone
    )
  end

  def load_user
    @user = User.find(params[:id])
  end

  def serialize_users(users)
    user_resources = users.map { |user| Api::V1::UserResource.new(user, nil) }
    JSONAPI::ResourceSerializer.new(Api::V1::UserResource).serialize_to_hash(
        user_resources
    )
  end
end
