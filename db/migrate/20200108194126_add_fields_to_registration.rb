class AddFieldsToRegistration < ActiveRecord::Migration[5.2]
  def change
    add_column :registrations, :first_name, :string
    add_column :registrations, :last_name, :string
    add_column :registrations, :organization, :string
  end
end
