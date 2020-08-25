class DropFieldsFromRegistration < ActiveRecord::Migration[5.2]
  def change
    remove_column :registrations, :company
    remove_column :registrations, :organization
  end
end
