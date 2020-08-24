class Accounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :first_name
      t.string :patronymic
      t.string :last_name
      t.string :phone_number
      t.string :company_name
      t.boolean :status, default: false

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
