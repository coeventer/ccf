class Admin::EventModeratorsController < Admin::AdminController
  def create
    @event = Event.find(params[:event_id])
    @moderator = @event.moderators.create(params[:event_moderator])

    respond_to do |format|
      format.js
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    
    @moderator = @event.moderators.find_by_user_id(params[:user_id])
    @moderator.destroy

    respond_to do |format|
      format.js
    end
  end
end
