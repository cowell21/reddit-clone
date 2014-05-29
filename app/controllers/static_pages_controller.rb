class StaticPagesController < ApplicationController

  def about
  end

  def update
    operation_add_aww
    operation_add_game
    operation_add
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

  def operation_add_aww
    data = JSON[open('http://www.reddit.com/r/aww/.json').read]

    data["data"]["children"].each do |post|
      if post["data"]["url"].length < 255 && post["data"]["url"].include?(".jpg") || post["data"]["url"].include?(".gif")
        title = post["data"]["title"].slice(0..254)
        url = post["data"]["url"]
        sub = post["data"]["subreddit"]
        Post.create( title: title, url: url, sub: sub, user_id: 2) unless Post.find_by_title(title)
      end
    end
  end

  def operation_add
    data = JSON[open('http://www.reddit.com/.json').read]

    data["data"]["children"].each do |post|
      if post["data"]["url"].length < 255 && post["data"]["url"].include?(".jpg") || post["data"]["url"].include?(".gif")
        title = post["data"]["title"].slice(0..254)
        url = post["data"]["url"]
        sub = post["data"]["subreddit"]
        Post.create( title: title, url: url, sub: sub, user_id: 2) unless Post.find_by_title(title)
      end
    end
  end

  def operation_add_game
    data = JSON[open('http://www.reddit.com/r/gaming/.json').read]

    data["data"]["children"].each do |post|
      if post["data"]["url"].length < 255 && post["data"]["url"].include?(".jpg") || post["data"]["url"].include?(".gif")
        title = post["data"]["title"].slice(0..254)
        url = post["data"]["url"]
        sub = post["data"]["subreddit"]
        Post.create( title: title, url: url, sub: sub, user_id: 2) unless Post.find_by_title(title)
      end
    end
  end

end
