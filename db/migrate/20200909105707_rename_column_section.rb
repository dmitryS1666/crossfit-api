class RenameColumnSection < ActiveRecord::Migration[5.2]
  def change
    remove_column :sections, :type
    add_column :sections, :section_type, :string
  end
end
