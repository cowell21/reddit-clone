class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false, unique: true
      t.string :password_digest
      t.string :session_token
      t.integer :fb_id

      t.timestamps
    end
  end
end
