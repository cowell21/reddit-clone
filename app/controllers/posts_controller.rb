class PostsController < ApplicationController
  before_action :require_login, only: [:new, :create]

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
    @posts = Post.all
    @posts = query(@posts) if params[:query]
    @posts = @posts.sort_by(&:sum_votes).reverse
    params[:count] ? @count = params[:count].to_i : @count = 0
    @total = @posts.length
    @pagesize = 5 # change index page size here

    #paganation happens here
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

  # def search
  # end

  # def edit
  # end

  # def update
  # end

  def show
    @post = Post.find(params[:id])
  end

  def upvote
    if current_user
      @post = Post.find(params[:id])
      vote(1) if current_user
      redirect_to root_url
    else
      flash[:errors] = ["Must be logged in to vote"]
      redirect_to new_session_url
    end
  end

  def downvote
    if current_user
      @post = Post.find(params[:id])
      vote(-1) if current_user
      redirect_to root_url
    else
      flash[:errors] = ["Must be logged in to vote"]
      redirect_to new_session_url
    end
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

  def vote(direction)

    @vote = Vote.find_by_post_id_and_user_id(@post.id, current_user.id)

    if @vote
      @vote.value == direction ? @vote.update_attributes(value: 0) : @vote.update_attributes(value: direction)
    else
      @post.votes.create(user_id: current_user.id, value: direction)
    end
  end

  def query(posts)
    arr = []
    posts.each do |post|
      arr.push(post) if post.title.downcase.include?(params[:query].downcase)
    end
    arr
  end

end
