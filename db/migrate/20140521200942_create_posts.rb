class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :url
      t.string :body
      t.string :sub
      t.integer :user_id
      t.integer :value, default: 0

      t.timestamps
    end
  end
end
