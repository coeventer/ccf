class Admin::EventsController < Admin::AdminController
  def show
    @event = Event.find(params[:id])
  end
  
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.create(params[:event])
    
    if @event.valid? then
      redirect_to admin_event_path(@event), :message => "Created event #{@event.title}"
    else
      render :new
    end
  end
  
  def edit
    @event = Event.find(params[:id])   
  end
  
  def update
    @event = Event.find(params[:id])    
    
    if @event.update_attributes(params[:event]) then
      redirect_to admin_event_path(@event), :message => "Updated event #{e.title}"
    else
      render :edit
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
