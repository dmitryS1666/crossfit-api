class Api::V1::ExercisesController < ApplicationController
   skip_before_action :doorkeeper_authorize!
   before_action :authorize_exercise_policy, only: %i[create update destroy_all destroy all_exercises]
   before_action :load_exercise, only: %i[show edit update]

   def destroy_all
      Exercise.delete_all
      render plain: nil, status: 200, content_type: 'application/json'
   end

   def create
      if Exercise.find_by_name(params[:name]).present?
         render json: { message: 'Exercise exist' }
      else
         @exercise = Exercise.new(exercise_params)

         if @exercise.save
            render plain: @exercise.to_json,
                   status: 200,
                   content_type: 'application/json'
         else
            render plain: @exercise.errors,
                   status: :unprocessable_entity,
                   content_type: 'application/json'
         end
      end
   end

   def update
      if @exercise.update(exercise_params)
         @exercise.save
         render plain: {
             id: @exercise.id, name: @exercise.name, price: @exercise.price
         }.to_json,
                status: 200,
                content_type: 'application/json'
      else
         render json: @exercise.errors, status: :unprocessable_entity
      end
   end

   def all_exercises
      render json: serialize_exercises(Exercise.all)
   end

   private

   def authorize_exercise_policy
      authorize Exercise, policy_class: ExercisePolicy
   end

   def exercise_params
      params.require(:exercise).permit(
          :name,
          :description,
          :videoUrl,
          :equipment
      )
   end

   def load_exercise
      @exercise = Exercise.find(params[:id])
   end

   def serialize_exercises(exercises)
      exercise_resources = exercises.map { |exercise| Api::V1::ExerciseResource.new(exercise, nil) }
      JSONAPI::ResourceSerializer.new(Api::V1::ExerciseResource).serialize_to_hash(
          exercise_resources
      )
   end

end
