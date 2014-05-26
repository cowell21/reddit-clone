class StaticPagesController < ApplicationController

  def root
  end

  def about
  end

  def update
    operation_add_aww
    operation_add
    redirect_to root_url
  end

  private
  def operation_add_aww
    data = JSON[open('http://www.reddit.com/r/aww/.json').read]

    data["data"]["children"].each do |post|
      if post["data"]["url"].length < 255 && post["data"]["url"].include?(".jpg") || post["data"]["url"].include?(".gif")
        title = post["data"]["title"].slice(0..254)
        url = post["data"]["url"]
        Post.create( title: title, url: url, user_id: 2) unless Post.find_by_title(title)
      end
    end
  end

  def operation_add
    data = JSON[open('http://www.reddit.com/.json').read]

    data["data"]["children"].each do |post|
      if post["data"]["url"].length < 255 && post["data"]["url"].include?(".jpg") || post["data"]["url"].include?(".gif")
        title = post["data"]["title"].slice(0..254)
        url = post["data"]["url"]
        Post.create( title: title, url: url, user_id: 2) unless Post.find_by_title(title)
      end
    end
  end

end
