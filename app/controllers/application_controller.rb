class ApplicationController < JSONAPI::ResourceController
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def current_user
    user = User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def current_user_damin
    user = User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token && User.find(doorkeeper_token.resource_owner_id).admin?
  end

  def user_not_authorized
    head :forbidden
  end

  def context
    {
      user: current_user

    }
  end






  # Doorkeeper code
  before_action :doorkeeper_authorize!

  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  helper_method :current_order

  def current_order
    session[:order_id] ? Order.find(session[:order_id]) : Order.new
  end

  protected

  # Devise methods
  # Authentication key(:username) and password field will be added automatically by devise.
  def configure_permitted_parameters
    added_attrs = %i[email first_name last_name]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  private

  # def rails_admin_path?
  #   controller_path =~ /rails_admin/ && Rails.env.development?
  # end

  # Doorkeeper methods
  # def current_resource_owner
  #   User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  # end
  #
  # def user_not_authorized
  #   if request.xhr?
  #     render json: "You are not authorized to perform this action.", status: 403
  #   else
  #     redirect_to root_path
  #   end
  # end
  #
  # def authenticate_scope!
  #   # send(:"authenticate_#{resource_name}!", force: true)
  #   self.resource = send(:"current_#{resource_name}")
  # end
  #
  # def current_user
  #   current_resource_owner
  # end

  # def authenticate_user!(options = {})
  #   head :unauthorized unless signed_in?
  # end

  # def current_user
  #   @current_user ||= super || User.find(@current_user_id)
  # end
  #
  # def signed_in?
  #   @current_user_id.present?
  # end
end
