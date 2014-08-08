class SessionsController < ApplicationController
  skip_before_filter :auth_required
  before_filter :check_organization

  def create 
    auth = request.env["omniauth.auth"]
    user = User.find_by_uid(auth["uid"]) || User.create_with_omniauth(auth, @organization)

    session[:user_id] = user.id
    session[:token] = auth["credentials"]["token"]
    session[:created_at] = Time.now

    # re-direct to active event or root path if there is no active event
    event = Event.live.first
    redirect_to (request.env['omniauth.origin'].nil? ? root_path : request.env['omniauth.origin'])
  end

  def signout
    destroy_session
    redirect_to root_url, :notice => "Signed out!"
  end

  def new

  end

  def check_organization
    url = Domainatrix.parse(request.env['omniauth.origin'])
    @organization = Organization.find_by_subdomain(url.subdomain) || nil
  end
end
