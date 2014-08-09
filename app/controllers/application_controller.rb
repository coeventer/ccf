class ApplicationController < ActionController::Base
  include ApplicationHelper
  before_filter :auth_required
  protect_from_forgery

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @current_user
  end
  helper_method :current_user

  def auth_required
    # If there is a current user, check session
    if current_user
      if Time.now - session[:created_at] < 120.minutes
        return true
      # Session is no longer valid, re-authentication needed.
      else
        destroy_session
        respond_to do |format|
          format.html {redirect_to signin_path, :notice => "Your session has timed out. Please re-authenticate." and return false}
          format.js {render 'sessions/new', layout: false}
        end
      end
    else
      respond_to do |format|
        format.html {redirect_to signin_path, :notice => "Your session has timed out. Please re-authenticate." and return false}
        format.js {render 'sessions/new', layout: false}
      end
    end
  end

  # Remove all traces of user session from application session cookie
  def destroy_session
    session[:user_id] = nil
    session[:token] = nil
    session[:created_at] = nil
  end
end
