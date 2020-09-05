class AddFieldToExercise < ActiveRecord::Migration[5.2]
  def change
    add_column :exercises, :user_id, :string
  end
end
