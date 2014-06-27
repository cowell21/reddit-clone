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

  def comments_by_parent(sort_type)
    comments_by_parent = Hash.new { |hash, key| hash[key] = [] }

    @comments = comments_sort(sort_type)

    @comments.each do |comment|
      comments_by_parent[comment.parent_id] << comment
    end

    comments_by_parent
  end

  def comments_sort(sort_type)
    #sum_votes is from the comment model
    return comments.sort_by(&:sum_votes).reverse unless (sort_type)
    return comments if sort_type == "oldest"
    comments.reverse
  end

  def sum_votes
    self.votes.sum(:value)
  end

end