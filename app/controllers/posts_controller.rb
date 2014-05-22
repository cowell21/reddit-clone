class PostsController < ApplicationController

  def new
    @post = Post.new
  end

  def create
    url_fix
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if @post.save
      redirect_to root_url
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def index
    @posts = Post.all.sort_by(&:value).reverse
    params[:count] ? @count = params[:count].to_i : @count = 0
    @total = @posts.length # need this to be used in erb
    @pagesize = 5

    #pagination logic # ?count=5
    if @count % @pagesize == 0 && @count < @total

      if (@count + @pagesize) > @posts.length
        @posts = @posts[@count...@total]
      else
        @posts = @posts[@count..(@count + @pagesize - 1)]
      end

    else
      @posts = @posts[0..(@pagesize - 1)] if @total > (@pagesize + 1)
    end

  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to root_url
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :body, :sub)
  end

  def url_fix
    if !params[:post][:url].include?("http://") && params[:post][:url] != ""
      params[:post][:url] =  "http://" + params[:post][:url]
    end
  end

end
