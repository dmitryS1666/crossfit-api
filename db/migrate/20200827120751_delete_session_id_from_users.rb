class DeleteSessionIdFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :SESSION_ID
  end
end
