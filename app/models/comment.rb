class Comment < ActiveRecord::Base
  #validates :body, :user, :link, presence: true
  validates :body, :user_id, :post_id, presence: true, null: false

  belongs_to :post, inverse_of: :comments
  belongs_to :user,
  class_name: "User", inverse_of: :comments

  has_many :child_comments,
              class_name: "Comment",
              foreign_key: :parent_id,
              primary_key: :id

  belongs_to :parent_comment,
              class_name: "Comment",
              foreign_key: :parent_id,
              primary_key: :id

  has_many :votes,
            class_name: "CommentVote",
            foreign_key: :comment_id,
            primary_key: :id

  def sum_votes
    # a.votes.sum(:value) <- works like this
    self.votes.sum(:value)
  end

end
