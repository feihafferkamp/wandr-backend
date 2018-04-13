class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    enable_extension :citext
    
    create_table :trips do |t|
      t.citext :name
      t.string :description
      t.integer :duration

      t.timestamps
    end
  end
end
