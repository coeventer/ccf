class Admin::UsersController < Admin::AdminController
  def index
    @users = User.paginate(:page => params[:page], :per_page => 30)
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user]) then
      redirect_to admin_users_path, :message => "Updated #{@user.name}"
    else
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])    

    if @user.destroy then
      redirect_to admin_users_path, :message => "Deleted #{@user.name}"
    else
      redirect_to admin_users_path, :message => "Unabled to delete #{@user.name}"
    end
  end
end
