class RegistrationAddUnp < ActiveRecord::Migration[5.2]
  def change
    add_column :registrations, :unp, :string
  end
end
