class SuperAdmin::UsersController < SuperAdmin::SuperAdminController
  def index
    @users = User.where("name <> 'Deactivated Account'").paginate(:page => params[:page], :per_page => 30)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user]) then
      redirect_to super_admin_users_path, :message => "Updated #{@user.name}"
    else
      render :edit
    end
  end

  def search
    query = "#{'%'}#{params[:query]}#{'%'}"
    @users = User.where(["(name like ? or department like ? or email like ?) and name <> 'Deactivated Account'", query, query, query])
    @users = @users.where(verified: 0) if params[:unverified].eql?("1")
    @users = @users.paginate(:page => params[:page], :per_page => 30)

    respond_to do |format|
      puts @users.inspect
      format.js
    end
  end
end