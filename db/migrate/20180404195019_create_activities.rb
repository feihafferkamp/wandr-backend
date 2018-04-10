class CreateActivities < ActiveRecord::Migration[5.1]
  def change
    create_table :activities do |t|
      t.string :name
      t.text :description
      t.decimal :cost, default: 0, precision: 8, scale:2
      t.datetime :start_time
      t.datetime :end_time
      t.string :address
      t.decimal :lat, precision: 10, scale: 6
      t.decimal :lng, precision: 10, scale: 6
      t.string :img, default: ''
      t.integer :trip_id
      t.integer :destination_id

      t.timestamps
    end
  end
end
