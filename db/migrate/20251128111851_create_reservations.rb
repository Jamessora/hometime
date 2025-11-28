class CreateReservations < ActiveRecord::Migration[8.0]
  def change
    create_table :reservations do |t|
      t.references :guest, null: false, foreign_key: true
      t.integer :adults, null: false
      t.integer :children, null: false, default: 0
      t.string :currency, null: false
      t.integer :guest_count, null: false
      t.integer :infants, null: false, default: 0
      t.integer :nights, null: false
      t.decimal :payout_price, precision: 10, scale: 2, null: false
      t.decimal :security_price, precision: 10, scale: 2, null: false
      t.string :status, null: false
      t.decimal :total_price, precision: 10, scale: 2, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false

      t.timestamps
    end
  end
end
