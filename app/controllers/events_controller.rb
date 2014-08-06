class EventsController < ApplicationController
  skip_before_filter :auth_required
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
    @user = current_user || User.new
    @registration = @event.registrations.find_by_user_id(@user.id)
    @new_project = Project.new

    @projects = @event.projects

    # Check for project sort variable and re-order if needed
    sort = params[:sort].to_s
    if !sort.nil? && ["created_at", "approved desc"].include?(sort) then
      @projects = @projects.order(sort)
    elsif !sort.nil? && ["helpers"].include?(sort)
      @projects = @projects.most_help
    # Default sort, use votes
    elsif !sort.nil? && ["comments"].include?(sort)
      @projects = @projects.most_commented
    else
      @projects = @projects.most_liked
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end
end
