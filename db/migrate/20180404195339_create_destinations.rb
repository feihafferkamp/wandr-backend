class CreateDestinations < ActiveRecord::Migration[5.1]
  def change
    create_table :destinations do |t|
      t.string :name
      t.text :description
      t.decimal :lat
      t.decimal :lng

      t.timestamps
    end
  end
end
