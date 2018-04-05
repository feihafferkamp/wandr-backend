class CreateTodos < ActiveRecord::Migration[5.1]
  def change
    create_table :todos do |t|
      t.string :task
      t.integer :priority
      t.datetime :due_date
      t.integer :user_id

      t.timestamps
    end
  end
end
