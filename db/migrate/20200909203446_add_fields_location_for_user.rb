class AddFieldsLocationForUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :longitude, :float
    add_column :users, :latitude, :decimal, :precision=>64, :scale=>12
  end
end
