class Admin::OrganizationInvitationsController < Admin::AdminController
  def index
    @organization = current_organization
  end
end
