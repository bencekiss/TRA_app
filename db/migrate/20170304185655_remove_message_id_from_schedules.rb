class RemoveMessageIdFromSchedules < ActiveRecord::Migration[5.0]
  def change
    remove_column :schedules, :message_id
  end
end
