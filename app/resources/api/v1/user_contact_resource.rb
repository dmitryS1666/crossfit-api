
class Api::V1::UserContactResource < JSONAPI::Resource
    attributes :first_name, :last_name, :phone1, :phone2, :email, :desc, :created_at, :updated_at

    relationship :user,
    to: :one, always_include_linkage_data: true, class_name: 'User'

end
