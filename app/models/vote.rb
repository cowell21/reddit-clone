class Vote < ActiveRecord::Base

  validates :post_id, :user_id, :value, presence: true, null: false

  belongs_to :post,
  class_name: "Post",
  foreign_key: :post_id,
  primary_key: :id

  belongs_to :user,
  class_name: "User",
  foreign_key: :user_id,
  primary_key: :id

end
