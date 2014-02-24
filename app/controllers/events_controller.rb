class EventsController < ApplicationController
  # GET /events
  # GET /events.json
  def index
    @events = Event.live

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.live.find(params[:id])
    @registration = @event.registrations.find_by_user_id(current_user.id)
    @new_project = Project.new

    @projects = @event.projects

    # Check for project sort variable and re-order if needed
    sort = params[:sort].to_s
    if !sort.nil? && ["created_at", "approved desc"].include?(sort) then
      @projects = @projects.order(sort)
    elsif !sort.nil? && ["volunteers"].include?(sort)    
      @projects = @projects.select("projects.*, COUNT(project_volunteers.id) as project_count").joins("left outer join project_volunteers on projects.id=project_volunteers.project_id").group("projects.id").order("project_count desc")  
    # Default sort, use votes
    else
      @projects = @projects.select("projects.*, COUNT(project_ratings.id) as project_count").joins("left outer join project_ratings on projects.id=project_ratings.project_id").group("projects.id").order("project_count desc")
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end
end
