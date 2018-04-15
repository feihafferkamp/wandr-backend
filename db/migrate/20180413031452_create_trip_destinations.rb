class CreateTripDestinations < ActiveRecord::Migration[5.1]
  def change
    create_table :trip_destinations do |t|
      t.integer :trip_id
      t.integer :destination_id
      t.date :arrival
      t.date :departure
      t.timestamps
    end
  end
end
