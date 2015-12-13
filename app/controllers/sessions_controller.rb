class SessionsController < ApplicationController
  skip_before_filter :auth_required
  before_filter :check_organization

  def create 
    auth = request.env["omniauth.auth"]
    user = ProviderUser.find_and_update_uid(auth) || User.create_with_omniauth(auth, @organization)

    session[:user_id] = user.id
    session[:token] = auth["credentials"]["token"]
    session[:created_at] = Time.now

    if user.email_confirmed?
      login_redirect(request.env["omniauth.params"]["register_for_event_id"])
    else
      redirect_to set_email_user_path(user)
    end
  end

  def signout
    destroy_session
    redirect_to root_url, :notice => "Signed out!"
  end

  def new
    redirect_to root_url if current_user
  end

  private
    # Redirect users to the root path, the active event path or to event registration
    def login_redirect(register_event_id=nil)
      if register_event_id
		    # Support a single sign in and register button
        event = @organization.events.find(register_event_id)

        # Only register this user if the user is not already registered
        already_registered = is_registered?(current_user.id, event.id)
        if (!already_registered)
          redirect_to new_event_event_registration_url(event, subdomain: @organization.subdomain)
        else
          redirect_to event_url(event, subdomain: @organization.subdomain)
        end
      else
        redirect_to (request.env['omniauth.origin'].nil? ? root_path : request.env['omniauth.origin'])
      end
    end

    def is_registered?(user_id, event_id)
      !EventRegistration.where(["user_id = ? AND event_id = ?", user_id, event_id]).first.nil?
    end
  def check_organization
    url = Domainatrix.parse(request.env['omniauth.origin'])
    @organization = Organization.find_by_subdomain(url.subdomain) || nil
  end
end
