class CommentVote < ActiveRecord::Base

  validates :comment_id, :user_id, :value, presence: true, null: false

  belongs_to :comment,
  class_name: "Comment",
  foreign_key: :comment_id,
  primary_key: :id

  belongs_to :user,
  class_name: "User",
  foreign_key: :user_id,
  primary_key: :id

end
