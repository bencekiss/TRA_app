class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :body
      t.string :to_number
      t.string :from_number
      t.timestamps
    end
  end
end
