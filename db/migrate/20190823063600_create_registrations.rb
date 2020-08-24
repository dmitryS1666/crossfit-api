class CreateRegistrations < ActiveRecord::Migration[5.2]
  def change
    create_table :registrations, &:timestamps
  end
end
