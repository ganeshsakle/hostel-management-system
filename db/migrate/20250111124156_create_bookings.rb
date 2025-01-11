class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.datetime :check_in_date
      t.string :status, null: false, default: "pending"
      t.bigint :user_id
      t.bigint :room_id

      t.timestamps
    end
  end
end
