class SessionsController < ApplicationController
  skip_before_filter :auth_required
  
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_uid(auth["uid"]) || User.create_with_omniauth(auth)
    
    session[:user_id] = user.id
    session[:token] = auth["credentials"]["token"]
    session[:created_at] = Time.now
    
    redirect_to root_path
  end

  def signout
    destroy_session
    redirect_to root_url, :notice => "Signed out!"
  end
  
  def new
    
  end
end
