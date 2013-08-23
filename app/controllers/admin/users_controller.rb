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
  end
  
  def destroy
    @user = User.find(params[:id])    
  end
end
