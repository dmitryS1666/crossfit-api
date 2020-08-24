class Api::V1::AccountsController < JSONAPI::ResourceController
   before_action :doorkeeper_authorize!
end
