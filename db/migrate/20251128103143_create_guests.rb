class CreateGuests < ActiveRecord::Migration[8.0]
  def change
    create_table :guests do |t|
      t.string :email,      null: false
      t.string :first_name, null: false
      t.string :last_name,  null: false
      t.text :phone_numbers, array: true, default: [], null: false

      t.timestamps
    end

    add_index :guests, :email, unique: true
  end
end
