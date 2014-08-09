class Admin::AdminController < OrganizationController
  before_filter :require_admin

  private
  def require_admin
    auth_required
    return true if current_organization.admin?(current_user)
    redirect_to root_path and return false
  end
end
