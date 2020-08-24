class AddUserToUserContacts < ActiveRecord::Migration[5.2]
  def change
    add_reference :user_contacts, :user, foreign_key: true
  end
end
