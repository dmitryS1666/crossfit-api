class CreateTraining < ActiveRecord::Migration[5.2]
  def change
    create_table :trainings do |t|
      t.string :name
      t.string :description
      t.string :start_time
      t.string :trainer_id
      t.text :sections, array: true, default: []
    end
  end
end
