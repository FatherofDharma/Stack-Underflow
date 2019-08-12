class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :is_admin?

  def current_user
    if session[:user_id]
    @current_user ||= User.find(session[:user_id])
    end
  end

  def is_admin?
    if session[:user_id]
      if User.find_by_id(session[:user_id]).admin == true
        true
      else
        false
      end
    end
  end

  def authorize
    if !current_user
      flash[:alert] = {:content => "Whoops! Please sign in!", :class => "alert alert-danger"}
      redirect_to '/'
    end
  end

end
