class Admin::EventModeratorsController < Admin::AdminController
  def index
    @event = Event.find(params[:event_id])
    @moderators = @event.moderators
    @registrants = @event.registrations
  end

  def create
    @event = Event.find(params[:event_id])
    @moderator = @event.moderators.create(user_id: params[:user_id])

    redirect_to admin_event_event_moderators_path
  end

  def destroy
    @event = Event.find(params[:event_id])

    @moderator = @event.moderators.find(params[:id])
    @moderator.destroy

    redirect_to admin_event_event_moderators_path
  end
end
