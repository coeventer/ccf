class Admin::ProjectsController < Admin::AdminController
  # GET /event_registrations/1
  # GET /event_registrations/1.json
  def index
    @event = Event.find_by_id(params[:event_id])
    if @event
      @projects = @event.projects
    else
      @projects = Project.backlog
    end

    respond_to do |format|
      format.html
      format.csv { render text: @projects.order("created_at").to_csv }
    end
  end

  def edit
    load_project
    @events = Event.live
  end

  def update
    load_project

    if @project.update_attributes(params[:project]) then
      redirect_to index_redirect_path, :message => "Updated #{@project.title}"
    else
      redirect_to index_redirect_path
    end
  end

  def destroy
    load_project

    if @project.destroy then
      redirect_to index_redirect_path, :message => "Successfully deleted <%=@project.title%>"
    else
      redirect_to index_redirect_path, :message => "Unable to delete project"
    end
  end

  def load_project
    @event = Event.find_by_id(params[:event_id])
    if @event
      @project = @event.projects.find(params[:id])
    else
      @project = Project.find(params[:id])
    end
  end

  def index_redirect_path
    if @event
      admin_event_projects_path(@event)
    else
      admin_project_path
    end
  end
end
