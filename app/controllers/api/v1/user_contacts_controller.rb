class Api::V1::UserContactsController < ApplicationController
  skip_before_action :doorkeeper_authorize!
  before_action :authorize_user_contacts_policy, only: %i[create update destroy]

  private

  def authorize_user_contacts_policy
    authorize UserContact, policy_class: UserContactPolicy
  end
end
