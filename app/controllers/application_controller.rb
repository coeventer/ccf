class ApplicationController < ActionController::Base
  before_filter :auth_required
  before_filter :find_events
  protect_from_forgery
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @current_user
  end
  
  def auth_required
    # If there is a current user, check session
    if current_user
      if Time.now - session[:created_at] < 60.minutes
        return true
      # Session is no longer valid, re-authentication needed.
      else
        destroy_session
        redirect_to root_url, :notice => "Your session has timed out. Please re-authenticate with Facebook."
        return false
      end
    else
      redirect_to new_session_path
      return false
    end
  end
  
  # Remove all traces of user session from application session cookie
  def destroy_session
    session[:user_id] = nil
    session[:token] = nil
    session[:created_at] = nil
  end
  
  helper_method :current_user

  def find_events
    @future_events = Event.live.where(["end_date >= ?", Date.today]) 
    @past_events = Event.live.where(["end_date < ?", Date.today]) 
  end
end
