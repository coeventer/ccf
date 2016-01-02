class UsersController < MixedUseController
  before_filter :load_user, except: [:set_email, :confirm_email]
  skip_before_filter :auth_required, only: [:set_email, :confirm_email]

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

  def set_email
    raise ActiveRecord::RecordNotFound unless session[:email_required]

    @user = User.find(session[:user_id])

    if params.fetch(:user, {})[:email]
      @user.set_unconfirmed_email(params[:user][:email])
    end
  end

  def confirm_email
    if params[:t]
      @user = User.where(email_confirmation_token: params[:t]).first!
      @user.confirm_email(params[:t])
      if @user.email_confirmed?
        flash[:notice] = "Your address #{@user.email} has been confirmed. Welcome!"
        session[:user_id] = @user.id
        session[:created_at] = Time.now
        session[:email_required] = nil
      else
        flash[:error] = "Your address #{@user.email} could not be confirmed."
        redirect_to root_path
      end
    end

    redirect_to root_path
  end

  private
    def load_user
     @user = User.find(params[:id])
    end
end
