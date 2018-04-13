class CreateDestinations < ActiveRecord::Migration[5.1]
  def change
    create_table :destinations do |t|
      t.string :name
      t.text :description
      t.decimal :lat, precision: 7, scale: 3
      t.decimal :lng, precision: 7, scale: 3

      t.timestamps
    end
  end
end
