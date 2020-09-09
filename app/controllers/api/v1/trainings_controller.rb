class Api::V1::TrainingsController < ApplicationController
   skip_before_action :doorkeeper_authorize!
   before_action :authorize_training_policy, only: %i[index create update destroy_all destroy all_trainings]
   before_action :load_training, only: %i[show edit update]

   def index
      if params[:trainer_id] && params[:name]
         training = Training.find_by_name_and_trainer_id(params[:name], params[:trainer_id])
         render json: { message: training }
      elsif params[:trainer_id]
         trainings = Training.all.where(trainer_id: params[:trainer_id])
         render json: { message: trainings }
      end
   end

   def destroy_all
      Training.delete_all
      render plain: nil, status: 200, content_type: 'application/json'
   end

   def create
      if Training.find_by_name_and_trainer_id(params[:name], params[:trainer_id]).present?
         render json: { message: "Training '#{params[:name]}' already exist" }
      else

         sections = []
         params[:sections].each do |section|
            actions = []
            if section[:actions]
               section[:actions].each do |action|
                  actions << Action.new(action.permit!)
               end
               section[:actions] = actions
            end
            sections << Section.new(section.permit!)
         end
         params[:sections] = sections
         @training = Training.new(training_params)

         if @training.save
            render plain: @training.to_json,
                   status: 200,
                   content_type: 'application/json'
         else
            render plain: @training.errors,
                   status: :unprocessable_entity,
                   content_type: 'application/json'
         end
      end
   end

   def update
      if @training.update(training_params)
         @training.save
         render plain: {
             id: @training.id,
             name: @training.name,
             description: @training.description,
             trainer_id: @training.trainer_id,
             sections: @training.sections
         }.to_json,
                status: 200,
                content_type: 'application/json'
      else
         render json: @training.errors, status: :unprocessable_entity
      end
   end

   def all_trainings
      render json: serialize_trainings(Training.all)
   end

   private

   def authorize_training_policy
      authorize Training, policy_class: TrainingPolicy
   end

   def training_params
      params.require(:training).permit(
          :name,
          :description,
          :trainer_id,
          :start_time,
          sections: [:duration, :start_minute, :section_type, actions: [:minute, :exercise_id, :default_value_man, :default_value_woman, :profile_index, :ratio, :reps, :distance]]
      )
   end

   def load_training
      @training = Training.find(params[:id])
   end

   def serialize_trainings(trainings)
      training_resources = trainings.map { |training| Api::V1::TrainingResource.new(training, nil) }
      JSONAPI::ResourceSerializer.new(Api::V1::TrainingResource).serialize_to_hash(
          training_resources
      )
   end

end
