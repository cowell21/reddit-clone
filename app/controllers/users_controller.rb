class UsersController < ApplicationController
  #before_action <-- may need to do

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      sign_in(@user)
      redirect_to root_url
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find(params[:id])

    @posts = @user.posts.sort_by(&:sum_votes).reverse

    #@posts = Post.all.sort_by(&:value).reverse
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

  private

  def user_params
    params.require(:user).permit(:username, :password, :session_token)
  end

  def facebook_info
    #returns facebook API data
    JSON[open("http://graph.facebook.com/?id=#{user.fb_id}").read]
  end

end