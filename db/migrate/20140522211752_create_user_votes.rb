class CreateUserVotes < ActiveRecord::Migration
  def change
    create_table :user_votes do |t|
      t.integer  "user_id"
      t.integer  "post_id"
      t.integer  "value", default: 0

      t.timestamps
    end
  end
end
