class CreateUserTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :user_trips do |t|
      t.integer :ratings
      t.integer :travel_age
      t.datetime :start_date
      t.datetime :end_date
      t.integer :user_id
      t.integer :trip_id

      t.timestamps
    end
  end
end
