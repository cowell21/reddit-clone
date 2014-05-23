class CreateUserVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer  "user_id"
      t.integer  "post_id"
      t.integer  "value", default: 0

      t.timestamps
    end

    add_index :votes, [:user_id, :post_id], :unique => true
  end
end
