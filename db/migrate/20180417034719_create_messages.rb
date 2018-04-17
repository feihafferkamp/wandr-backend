class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :content
      t.integer :sender_id, foreign_key: true
      t.integer :receiver_id, foreign_key: true

      t.timestamps
    end
  end
end
