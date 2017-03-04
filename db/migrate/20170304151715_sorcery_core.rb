class SorceryCore < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :email,            :null => false
      t.string :crypted_password
      t.string :salt
      t.string :phone
      t.string :name
      t.string :secondary_name
      t.string :secondary_phone
      t.string :secondary_email
      t.string :emergency_name
      t.string :emergency_phone
      t.string :patient_name
      t.string :patient_number
      t.string :patient_address
      t.text :patient_notes

      t.timestamps
    end

    add_index :accounts, :email, unique: true
  end
end
