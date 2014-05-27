class CreateCommentVotes < ActiveRecord::Migration
  def change
    create_table :comment_votes do |t|
      t.integer  :user_id, null: false
      t.integer  :comment_id, null: false
      t.integer  :value, default: 0

      t.timestamps
    end

    add_index :comment_votes, [:user_id, :comment_id], :unique => true
  end
end
