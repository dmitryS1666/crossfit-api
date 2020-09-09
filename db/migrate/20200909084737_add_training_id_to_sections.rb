class AddTrainingIdToSections < ActiveRecord::Migration[5.2]
  def change
    add_column :sections, :training_id, :string
  end
end
