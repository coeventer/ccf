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
  
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end
end
