class CreateUserContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :user_contacts do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone1
      t.string :phone2
      t.string :email
      t.text :desc

      t.timestamps
    end
  end
end
