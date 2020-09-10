class CreateTicket < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
        t.integer :duration
        t.integer :visits
        t.integer :price
    end
  end
end
