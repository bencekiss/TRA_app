class AddColumnToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :schedule_id, :integer
    add_column :messages, :status, :string
  end
end
