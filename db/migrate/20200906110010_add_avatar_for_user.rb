class AddAvatarForUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :avatar, :text, limit: 16.megabytes - 1
  end
end
