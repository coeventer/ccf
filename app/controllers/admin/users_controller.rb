class Admin::UsersController < Admin::AdminController
  before_filter :find_user, only: [:show, :edit, :update, :destroy, :verify, :canonize]
  def index
    @users = current_organization.users
    @users = @users.unverified if params[:unverified] == "1"
    @users = @users.paginate(:page => params[:page], :per_page => 30)
  end

  def show
    
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:organization_user]) then
      redirect_to admin_users_path, :message => "Updated #{@user.user_name}"
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy then
      redirect_to admin_users_path, :message => "Deleted #{@user.user_name} from organization"
    else
      redirect_to admin_users_path, :message => "Unabled to delete #{@user.user_name} from organization"
    end
  end

  def verify
    @user.update_attributes(verified: true)
    redirect_to admin_users_path(params.slice(:unverified)), :message => "Verified #{@user.user_name}"
  end

  def canonize
    @user.update_attributes(admin: true)
    redirect_to admin_users_path(params.slice(:unverified)), :message => "#{@user.user_name} now an organization admin"
  end

  def find_user
    @user = current_organization.users.find(params[:id])
  end

  def search
    query = "#{'%'}#{params[:query]}#{'%'}"
    @users = current_organization.users.joins(:user).where(["name like ? or department like ? or email like ?", query, query, query])
    @users = @users.where(verified: 0) if params[:unverified].eql?("1")
    @users = @users.paginate(:page => params[:page], :per_page => 30)

    respond_to do |format|
      puts @users.inspect
      format.js
    end
  end
end
