class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.string :room_description
      t.bigint :hostel_id

      t.timestamps
    end
  end
end
