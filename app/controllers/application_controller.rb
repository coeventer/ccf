class ApplicationController < ActionController::Base
  layout "application"
  include ApplicationHelper
  before_filter :auth_required
  protect_from_forgery

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @current_user
  end
  helper_method :current_user

  def alerts
    return nil unless current_user

    current_user.pending_invitations
  end
  helper_method :alerts

  def auth_required
    # If there is a current user, check session
    return true if current_user
      
    respond_to do |format|
      format.html {redirect_to signin_path, :notice => "Your session has timed out. Please re-authenticate." and return false}
      format.js {render 'sessions/new', layout: false}
    end

    false
  end

  # Remove all traces of user session from application session cookie
  def destroy_session
    session[:user_id] = nil
    session[:token] = nil
    session[:created_at] = nil
  end
end
