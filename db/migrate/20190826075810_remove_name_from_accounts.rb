class RemoveNameFromAccounts < ActiveRecord::Migration[5.2]
  def change
    remove_column :accounts, :first_name, :string
    remove_column :accounts, :patronymic, :string
    remove_column :accounts, :last_name, :string
    remove_column :accounts, :user_id, :string
  end
end
