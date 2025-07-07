class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :require_user, :logged_in?, :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:alert] = "You must be logged in"
      redirect_to articles_path
    end
  end
end
