class SessionsController < ApplicationController

  before_action :redirect_if_logged_in, only: [:new]

  def create
    user = User.find_by_credentials(session_params)

    if user
      login_user!(user)

      redirect_to cats_url
    else
      flash[:errors] = "Invalid Username and Password."
      redirect_to new_session_url
    end
  end

  def new
    render :new
  end

  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
    end

    redirect_to new_session_url
  end



  private

  def session_params
    params.require(:session).permit(:username, :password)
  end

end
