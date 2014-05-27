# post_comments_url(@post) # index

json.title @post.title
json.url @post.url
json.user_id @post.user.id
json.username @post.user.username

# comments

json.comments @comments do |comment|
  json.id comment.id
  json.body comment.body
  json.user_id comment.user_id
  json.parent_id comment.parent_id
  json.username comment.user.username
end