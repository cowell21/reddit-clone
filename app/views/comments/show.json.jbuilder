# comment show

json.id @comment.id
json.body @comment.body
json.user_id @comment.user.id
json.username @comment.user.username
json.score @comment.votes.sum(:value)