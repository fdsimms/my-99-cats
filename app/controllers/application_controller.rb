class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :current_users_cat?

  def current_user
    if session[:session_token]
      @current_user ||= User.find_by_session_token(session[:session_token])
    end
  end

  def login_user!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def logged_in?
    !!current_user
  end

  def current_users_cat?(cat)
    cat.user_id == current_user.id if current_user
  end

  private

  def redirect_if_logged_in
    redirect_to cats_url if logged_in?
  end

  def verify_logged_in
    unless logged_in?
      flash[:errors] = "You must be logged in to do that."
      redirect_to new_session_url
    end
  end
end
