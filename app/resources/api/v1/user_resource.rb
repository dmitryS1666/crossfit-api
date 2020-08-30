class Api::V1::UserResource < JSONAPI::Resource
  attributes :email, :first_name, :last_name, :phone
  has_one :account
  has_many :user_contacts
end
