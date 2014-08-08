class SessionsController < ApplicationController
  skip_before_filter :auth_required

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_uid(auth["uid"]) || User.create_with_omniauth(auth)

    session[:user_id] = user.id
    session[:token] = auth["credentials"]["token"]
    session[:created_at] = Time.now

    login_redirect(request.env["omniauth.params"]["register_for_event_id"])
  end

  def signout
    destroy_session
    redirect_to root_url, :notice => "Signed out!"
  end

  def new

  end

  private
    # Redirect users to the root path, the active event path or to event registration
    def login_redirect(register_event_id)
      if register_event_id
		    # Support a single sign in and register button
        event = Event.find(register_event_id)
        redirect_to new_event_event_registration_path(event)
      else
        # re-direct to active event or root path if there is no active event
        event = Event.live.first
        redirect_to (event.nil? ? root_path : event_path(event))
      end
    end
end
