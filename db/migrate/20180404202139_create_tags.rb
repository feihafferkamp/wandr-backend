class CreateTags < ActiveRecord::Migration[5.1]
  def change
    enable_extension :citext

    create_table :tags do |t|
      t.citext :name, unique: true
      t.timestamps
    end
  end
end
