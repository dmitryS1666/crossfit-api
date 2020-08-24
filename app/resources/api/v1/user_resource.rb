class Api::V1::UserResource < JSONAPI::Resource
  attributes :email, :first_name, :last_name, :phone, :account_id, :organization, :unp
  has_one :account
  has_many :user_contacts
end
