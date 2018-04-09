class CreateUserTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :user_trips do |t|
      t.integer :ratings, default: nil
      t.integer :travel_age
      t.date :start_date
      t.date :end_date
      t.integer :user_id
      t.integer :trip_id

      t.timestamps
    end
  end
end
