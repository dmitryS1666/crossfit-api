class CreateTableExercise < ActiveRecord::Migration[5.2]
  def change
    create_table :exercises do |t|
        t.string :name
        t.string :description
        t.string :videoUrl
        t.string :equipment

        t.timestamps
    end
  end
end
