class Admin::EventsController < Admin::AdminController
  def index
    @events = current_organization.events.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.create(params[:event])

    if @event.valid? then
      redirect_to admin_event_builder_path(@event, :registration)
    else
      render :new
    end
  end

  def destroy
    @event = Event.find(params[:id])

    if @event.destroy then
      redirect_to admin_root_path, :message => "Deleted event #{@event.title}"
    else
      redirect_to admin_root_path, :message => "Unable to delete the event"
    end
  end
end
