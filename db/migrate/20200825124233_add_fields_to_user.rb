class AddFieldsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :SESSION_ID, :string
    add_column :users, :client, :string
    add_column :users, :birthDate, :string
    add_column :users, :sex, :string
    add_column :users, :purchaseTime, :string
    add_column :users, :hight, :integer, default: 0
    add_column :users, :weight, :integer, default: 0
    add_column :users, :backSquat, :integer, default: 0
    add_column :users, :frontSquat, :integer, default: 0
    add_column :users, :clean_and_jerk, :integer, default: 0
    add_column :users, :snatch, :integer, default: 0
    add_column :users, :benchPress, :integer, default: 0
    add_column :users, :deadlift, :integer, default: 0
    add_column :users, :overheadPress, :integer, default: 0
    add_column :users, :subscriptionId, :integer, default: 0
    add_column :users, :ticketId, :integer, default: 0
    add_column :users, :trainerId, :integer, default: 0
    add_column :users, :duration, :integer, default: 0
    add_column :users, :visits, :integer, default: 0
    add_column :users, :price, :integer, default: 0
    add_column :users, :attendanceTime, :integer, default: 0
    add_column :users, :trainingId, :integer, default: 0
    add_column :users, :trainer, :string
    add_column :users, :tickets, :integer, default: 0
    add_column :users, :club, :string
    add_column :users, :description, :string

    add_column :users, :attendances, :text, array: true, default: []
    add_column :users, :subscriptions,:text, array: true, default: []
  end
end
