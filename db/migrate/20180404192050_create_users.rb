class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    enable_extension :citext

    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :email, unique: true
      t.date :dob
      t.string :photo, default: ''
      t.string :hometown
      t.citext :username, unique: true
      t.string :password_digest

      t.timestamps
    end
  end
end
