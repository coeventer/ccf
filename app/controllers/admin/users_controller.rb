class Admin::UsersController < Admin::AdminController
  def index
    @users = current_organization.users.includes(:user).paginate(:page => params[:page], :per_page => 30)
  end

  def show
    @user = current_organization.users.where(user_id: params[:id]).first.user
  end

  def edit
    @user = current_organization.users.where(user_id: params[:id]).first.user
  end

  def update
    @user = current_organization.users.where(user_id: params[:id]).first.user
    if @user.update_attributes(params[:user]) then
      redirect_to admin_users_path, :message => "Updated #{@user.name}"
    else
      render :edit
    end
  end

  def destroy
    current_organization.users.find(user_id: params[:id]).first.user

    if @user.destroy then
      redirect_to admin_users_path, :message => "Deleted #{@user.name}"
    else
      redirect_to admin_users_path, :message => "Unabled to delete #{@user.name}"
    end
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
