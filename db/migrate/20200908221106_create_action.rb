class CreateAction < ActiveRecord::Migration[5.2]
  def change
    create_table :actions do |t|
      t.integer :minute
      t.string :exercise_id
      t.integer :default_value_man
      t.integer :default_value_woman
      t.string :profile_index
      t.integer :ratio
      t.integer :reps
      t.integer :distance
    end
  end
end
