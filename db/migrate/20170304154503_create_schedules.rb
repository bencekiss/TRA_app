class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.text :template
      t.integer :message_id
      t.integer :account_id
      t.datetime :schedule_time

      t.timestamps
    end
  end
end
