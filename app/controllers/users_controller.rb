class UsersController < ApplicationController

  before_action :redirect_if_logged_in, only: [:new]

  def new
    @user = User.new

    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login_user!(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = @user.errors
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end
