class EventCommentsController < OrganizationController
  before_filter :verification_required
  def create
    @event = Event.find(params[:event_id])

    authorize! :create, @event.event_comments.new
    @comment = @event.event_comments.new(params[:event_comment])
    @comment.user = current_user
    @comment.save

    @event = Event.find(params[:event_id])

    respond_to do |format|
     format.js
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @comment = @event.event_comments.find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy

    respond_to do |format|
      format.js {render :create}
    end
  end
end
