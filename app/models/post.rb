class Post < ActiveRecord::Base
  validates :title, presence: true, null: false
  validates :user_id, presence: true, null: false

end
