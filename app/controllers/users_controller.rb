class UsersController < OrganizationController
  before_filter :verification_required
  before_filter :load_user

  def show
  end

  # GET /projects/1/edit
  def edit
    authorize! :edit, @user
  end

  def update
    authorize! :update, @user
    if @user.update_attributes(params[:user].except(:admin, :verified, :uid, :department)) then
      redirect_to  edit_user_path(current_user), :notice => "Updated Account For #{@user.name}"
    else
      render :edit
    end
  end

  private
    def load_user
     @user = User.find(params[:id])
    end
end
