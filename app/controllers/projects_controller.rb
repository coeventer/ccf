class ProjectsController < OrganizationController
  skip_before_filter :auth_required, :only => [:show]
  before_filter :verification_required, :except => [:show]
  load_and_authorize_resource :except => [:rate, :volunteer, :unvolunteer]

  def index
    @projects = Project.backlog
    sort_projects
    @new_project = Project.new
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @events = Event.live
  end

  def new

  end

  # POST /projects
  # POST /projects.json
  def create
    @project.project_owner = current_user

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # Only responds to js
  def rate
    @project = Project.find(params[:id])
    @project.toggle_vote(current_user)

    respond_to do |format|
      format.js
    end
  end

  # Only responds to js
  def volunteer
    @project = Project.find(params[:id])
    @volunteer = @project.volunteer(current_user)

    respond_to do |format|
      format.js
    end
  end

  # Only responds to js
  def unvolunteer
    @project = Project.find(params[:id])
    @project.unvolunteer(current_user)

    respond_to do |format|
      format.js {render :volunteer}
    end
  end
end
