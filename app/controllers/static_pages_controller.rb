class StaticPagesController < ApplicationController

  def about
  end

  def update
    json_urls =[
      "http://www.reddit.com/.json",
      "http://www.reddit.com/r/aww/.json",
      "http://www.reddit.com/r/funny/.json",
      "http://www.reddit.com/r/pics/.json",
    ]
    #"http://www.reddit.com/r/AskReddit/.json"

    json_urls.each do |json_url|
      operation_add(json_url)
    end

    redirect_to new_url
  end

  def new
    @posts = Post.all
    @posts = @posts.sort_by(&:created_at).reverse

    pagination
  end

  def rising
    @posts = Post.all
    @posts = @posts.sort_by(&:sum_votes).reverse

    pagination
  end

  def all
    @posts = Post.all
    @posts = @posts.sort_by(&:sum_votes).reverse

    pagination
  end

  def random
    @posts = Post.all
    @posts = @posts.shuffle

    pagination
  end

  private
  def pagination
    params[:count] ? @count = params[:count].to_i : @count = 0
    @total = @posts.length
    @pagesize = 10 # change index page size here

    if @count % @pagesize == 0 && @count < @total
      if (@count + @pagesize) > @posts.length
        @posts = @posts[@count...@total]
      else
        @posts = @posts[@count...(@count + @pagesize)]
      end
    else
      @posts = @posts[0..(@pagesize - 1)] if @total > (@pagesize + 1)
    end
  end

  def operation_add(json_url)
    data = JSON[open(json_url).read]

    data["data"]["children"].each do |post|
      if post["data"]["url"].length < 255 && post["data"]["url"].include?(".jpg") || post["data"]["url"].include?(".gif")
        title = post["data"]["title"].slice(0..254)
        url = post["data"]["url"]
        sub = post["data"]["subreddit"]
        #post["data"]["subreddit"] ? body = post["data"]["selftext_html"] : body = ""
        Post.create( title: title, url: url, body: body, sub: sub, user_id: 2) unless Post.find_by_title(title)
      end
    end
  end

end
