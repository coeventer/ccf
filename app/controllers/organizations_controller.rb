class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.paginate(:page => params[:page], :per_page => 25)
  end

  def show

  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(params[:organization])

    if @organization.save then
      @organization.users.create(user: current_user, admin: true, verified: true)
      redirect_to root_path
    else
      render :new
    end
  end
end
