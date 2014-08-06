class Admin::ProjectsController < ApplicationController
  # GET /event_registrations/1
  # GET /event_registrations/1.json
  def index
    @event = Event.find(params[:event_id])
    @projects = @event.projects

    respond_to do |format|
      format.html
      format.csv { render text: @event.projects.order("created_at").to_csv }
    end
  end

  def edit
    @event = Event.find(params[:event_id])
    @project = @event.projects.find(params[:id])
  end

  def update
    @event = Event.find(params[:event_id])
    @project = @event.projects.find(params[:id])

    if @project.update_attributes(params[:project]) then
      redirect_to admin_event_projects_path(@event), :message => "Updates #{@project.title}"
    else
      redirect_to edit_admin_event_project_path(@event, @project)
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @project = @event.projects.find(params[:id])

    if @project.destroy then
      redirect_to admin_event_projects_path(@event), :message => "Successfully deleted <%=@project.title%>"
    else
      redirect_to admin_event_projects_path(@event), :message => "Unable to delete project"
    end
  end
end