class ChangeNameFieldUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :hight
    add_column :users, :height, :integer, default: 0
  end
end
