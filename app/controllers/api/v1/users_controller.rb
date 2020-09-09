class Api::V1::UsersController < ApplicationController
  # skip_before_action :doorkeeper_authorize!
  before_action :authorize_user_policy, only: %i[create update destroy all_users]
  before_action :load_user, only: %i[show edit update]

  def show
    render json: @user
  end

  def all_users
    render json: serialize_users(User.all)
  end

  def update
    if @user.update(user_params)
      @user.save
      render json: @user
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
        :phone,
        :email,
        :created_at,
        :updated_at,
        :first_name,
        :last_name,
        :phone,
        :birthDate,
        :sex,
        :purchaseTime,
        :weight,
        :backSquat,
        :frontSquat,
        :clean_and_jerk,
        :snatch,
        :benchPress,
        :deadlift,
        :overheadPress,
        :subscriptionId,
        :ticketId,
        :trainerId,
        :duration,
        :visits,
        :price,
        :attendanceTime,
        :trainingId,
        :tickets,
        :club,
        :description,
        :attendances,
        :subscriptions,
        :trainer,
        :client,
        :height,
        :avatar,
        :longitude,
        :latitude
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
