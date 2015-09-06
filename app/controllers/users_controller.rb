class UsersController < MixedUseController
  before_filter :load_user

  def show
    @attended = EventRegistration.unscoped.where(user_id: @user.id).count
    @ideas = Project.unscoped.where(submitted_user_id: @user.id).count
    @comments = ProjectComment.unscoped.where(user_id: @user.id).count
    @likes = ProjectRating.unscoped.where(user_id: @user.id).count
    @helps = ProjectVolunteer.unscoped.where(user_id: @user.id).count
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

  def deactivate
    authorize! :update, @user
    if @user.deactivate
      destroy_session
      redirect_to root_path, message: "Your account has been deactivated. If you wish to participate in the future, a new account will be create."
    else
      redirect_to root_path, notice: "Unable to deactive your user account. Please contact us."
    end
  end

  private
    def load_user
     @user = User.find(params[:id])
    end
end
