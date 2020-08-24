class Api::V1::AccountResource < JSONAPI::Resource
  attributes :phone_number, :company_name, :status, :title, :desc, :itin, :code
  has_one :user
end

