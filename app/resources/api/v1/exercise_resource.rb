class Api::V1::ExerciseResource < JSONAPI::Resource
  attributes :name, :description, :videoUrl, :equipment
end