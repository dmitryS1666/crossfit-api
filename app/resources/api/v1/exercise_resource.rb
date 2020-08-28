class Api::V1::ExerciseResource < JSONAPI::Resource
  attributes :name, :description, :videoUrl, :equipment
  # has_one :account
  # has_many :user_contacts
end