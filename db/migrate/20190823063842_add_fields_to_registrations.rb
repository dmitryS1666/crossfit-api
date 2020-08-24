class AddFieldsToRegistrations < ActiveRecord::Migration[5.2]
  def change
    add_column :registrations, :email, :string
    add_column :registrations, :complete, :boolean
    add_column :registrations, :token, :string
    add_column :registrations, :name, :string
    add_column :registrations, :company, :string
    add_column :registrations, :phone, :string
    add_column :registrations, :password, :string
  end
end
