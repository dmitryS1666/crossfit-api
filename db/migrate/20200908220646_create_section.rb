class CreateSection < ActiveRecord::Migration[5.2]
  def change
    create_table :sections do |t|
        t.integer :duration
        t.integer :start_minute
        t.string :type
    end
  end
end
