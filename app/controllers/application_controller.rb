class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?, :admin?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def admin?
    current_user.admin if current_user
  end

  def require_user
    if !logged_in
      flash[:danger] = "You must be logged in to view that page."
      redirect_back fallback_location: home_url
    end
  end

  def require_admin
    if !admin?
      flash[:danger] = "You do not have permission to view that page."
      redirect_back fallback_location: home_url
    end
  end

end
