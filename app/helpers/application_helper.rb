module ApplicationHelper

  def comment_partial(comment, comments_by_parent)
    render(
      partial: "comments/comment",
      locals: { comment: comment, comments_by_parent: comments_by_parent }
      )
  end

  def time_ago(created_time)
    time_dif = Time.now.to_i - created_time.to_i
    return " just now" if time_dif < 60
    return " #{time_dif  / 60} mintues ago" if time_dif < 3600
    return " #{time_dif / 3600} hours ago" if time_dif < 86400
    " #{time_dif / 86400} days ago"
  end

end
