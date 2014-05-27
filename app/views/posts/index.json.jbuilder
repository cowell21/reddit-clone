json.posts @posts do |post|
  json.title post.title
  json.url post.url
  json.user_id post.user.id
  json.username post.user.username
  json.score post.votes.sum(:value)
end