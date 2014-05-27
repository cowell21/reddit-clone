class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :body, null: false
      t.integer :parent_id
      t.integer :post_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
