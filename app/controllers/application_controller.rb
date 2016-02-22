class ApplicationController < ActionController::Base
  layout "application"
  include ApplicationHelper
  before_filter :auth_required
  protect_from_forgery

  def current_user
    @current_user ||= User.email_confirmed.find_by_id(session[:user_id]) if session[:user_id]
    @current_user
  end
  helper_method :current_user, :allow_development_provider?

  def alerts
    return nil unless current_user

    current_user.pending_invitations
  end
  helper_method :alerts

  def auth_required
    # If there is a current user, check session
    return true if current_user
      
    respond_to do |format|
      format.html {redirect_to new_session_path(return_to: "#{request.url}") and return false}
      format.js {render 'sessions/new', layout: false}
    end

    false
  end

  # Remove all traces of user session from application session cookie
  def destroy_session
    session[:user_id] = nil
    session[:token] = nil
    session[:created_at] = nil
    session[:email_required] = nil
  end

  def allow_development_provider?
    Rails.env.development? || Rails.env.test?
  end
end
