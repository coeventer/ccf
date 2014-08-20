class Admin::OrganizationsController < Admin::AdminController
  def show
    @organization = current_organization
  end

  def edit
    @organization = current_organization
  end

  def update
    @organization = current_organization

    if @organization.update_attributes(params[:organization])
      redirect_to admin_root_path, :message => "Updated organization"
    else
      render :edit
    end
  end
end