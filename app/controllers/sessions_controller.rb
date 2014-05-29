class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    current_url = params[:url]
    @user = User.find_by_credentials(
    user_params[:username],
    user_params[:password])

    if @user
      sign_in(@user)
      redirect_to current_url
    else
      flash.now[:errors] = ["Invalid Username/Password Combo"]
      @user = User.new
      render :new
    end

  end

  def destroy
    sign_out
    redirect_to root_url
  end

  private
  def user_params
    params.require(:user).permit(:username, :password)
  end

end
