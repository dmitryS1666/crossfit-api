class Api::V1::UsersController < ApplicationController
  # skip_before_action :doorkeeper_authorize!
  before_action :authorize_user_policy, only: %i[create update destroy all_users]

  def all_users
    render json: serialize_users(User.all)
  end

  private

  def authorize_user_policy
    authorize current_user, policy_class: UserPolicy
  end

  def serialize_users(users)
    user_resources = users.map { |user| Api::V1::UserResource.new(user, nil) }
    JSONAPI::ResourceSerializer.new(Api::V1::UserResource).serialize_to_hash(
        user_resources
    )
  end
end
