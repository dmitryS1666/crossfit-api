class Api::V1::ActionResource < JSONAPI::Resource
  attributes :minute, :exercise_id, :default_value_man,
             :profile_index, :ratio, :reps, :distance
end