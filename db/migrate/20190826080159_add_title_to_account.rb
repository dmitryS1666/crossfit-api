class AddTitleToAccount < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :title, :string
    add_column :accounts, :desc, :text
    add_column :accounts, :itin, :string
  end
end
