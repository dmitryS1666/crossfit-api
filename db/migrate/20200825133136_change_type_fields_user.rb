class ChangeTypeFieldsUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :trainer
    remove_column :users, :client
    add_column :users, :trainer, :boolean, default: false
    add_column :users, :client, :boolean, default: false
  end
end
