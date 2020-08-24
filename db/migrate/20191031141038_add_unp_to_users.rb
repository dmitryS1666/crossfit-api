class AddUnpToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :unp, :string
  end
end
