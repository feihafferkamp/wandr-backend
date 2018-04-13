class CreateDestinations < ActiveRecord::Migration[5.1]
  def change
    enable_extension :citext

    create_table :destinations do |t|
      t.citext :name
      t.text :description
      t.decimal :lat, precision: 7, scale: 3
      t.decimal :lng, precision: 7, scale: 3

      t.timestamps
    end
  end
end
