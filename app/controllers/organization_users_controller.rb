class OrganizationUsersController < OrganizationController
  skip_before_filter :find_events

  def create
    if OrganizationUser.create(user_id: current_user.id, organization_id: current_organization.id)
      redirect_to root_path, :message => "Successfully joined organization"
    else
      redirect_to root_path, :message => "Unabled to join organization"
    end
  end
end