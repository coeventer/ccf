class SuperAdmin::OrganizationsController < SuperAdmin::SuperAdminController
  def index
    @organizations = Organization.paginate(:page => params[:page], :per_page => 30)
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:id])

    if @organization.update_attributes(params[:organization])
      redirect_to super_admin_organizations_path, :message => "Updated organization"
    else
      render :edit
    end
  end

  def search
    query = "#{'%'}#{params[:query]}#{'%'}"
    @organizations = Organization.where("name like ? or subdomain like ? ", query, query)
    @organizations = @organizations.paginate(:page => params[:page], :per_page => 30)

    respond_to do |format|
      puts @organizations.inspect
      format.js
    end
  end
end