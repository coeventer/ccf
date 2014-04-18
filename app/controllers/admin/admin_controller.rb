class Admin::AdminController < ApplicationController
  before_filter :require_admin
  
  private
  def require_admin
    auth_required
    return true if current_user.admin? && current_user.verified?
    redirect_to root_path and return false
  end
end
