class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title, null: false
      t.string :url
      t.string :body
      t.string :sub, default: "sub"
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
