class Api::V1::TrainingResource < JSONAPI::Resource
  attributes :name, :description, :trainer_id, :sections
  # has_many :sections
end