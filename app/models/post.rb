class Post < ActiveRecord::Base
  validates :title, presence: true, null: false
  validates :user_id, presence: true, null: false

  belongs_to :user, inverse_of: :posts

  has_many :comments,
  class_name: "Comment",
  foreign_key: :post_id,
  primary_key: :id

  has_many :votes,
  class_name: "Vote",
  foreign_key: :post_id,
  primary_key: :id

  def comments_by_parent
    comments_by_parent = Hash.new { |hash, key| hash[key] = [] }

    @comments = comments_sort

    @comments.each do |comment|
      comments_by_parent[comment.parent_id] << comment
    end

    comments_by_parent
  end

  def comments_sort
    #sum_votes is from the comment model
    #add more sort methods here
    comments.sort_by(&:sum_votes).reverse
  end

  def sum_votes
    # a.votes.sum(:value) <- works like this
    self.votes.sum(:value)
  end

end