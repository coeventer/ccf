class OrganizationsController < ApplicationController

  skip_before_filter :auth_required, :only => [:index]

  def index
    @organizations = Organization.paginate(:page => params[:page], :per_page => 25)
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(params[:organization])

    if @organization.save then
      @organization.users.create(user: current_user, admin: true, verified: true)
      redirect_to admin_after_create_path(subdomain: @organization.subdomain)
    else
      render :new
    end
  end
end
