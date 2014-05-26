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

  def operation_add_aww
    jsondata = open('http://www.reddit.com/r/aww/.json')
    data = JSON[jsondata.read]

    data["data"]["children"].each do |post|
      if post["data"]["url"].include?(".jpg") || post["data"]["url"].include?(".gif")
        title = post["data"]["title"]
        url = post["data"]["url"]
        Post.create( title: title, url: url, user_id: 2) unless Post.find_by_title(title)
      end
    end
  end

  def operation_add
    jsondata = open('http://www.reddit.com/.json')
    data = JSON[jsondata.read]

    data["data"]["children"].each do |post|
      if post["data"]["url"].include?(".jpg") || post["data"]["url"].include?(".gif")
        title = post["data"]["title"]
        url = post["data"]["url"]
        Post.create( title: title, url: url, user_id: 2) unless Post.find_by_title(title)
      end
    end
  end



end
