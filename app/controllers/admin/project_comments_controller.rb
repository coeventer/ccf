class Admin::ProjectCommentsController < Admin::AdminController
  def index
    @event = Event.find(params[:event_id])
    @project = Project.find(params[:project_id])
    @comments = @project.comments
  end

  def destroy
    @event = Event.find(params[:event_id])
    @project = Project.find(params[:project_id])
    @comment = @project.comments.find(params[:id])    

    if @comment.destroy then
      redirect_to admin_event_project_project_comments_path(@event, @project), :message => "Deleted comment"
    else
      redirect_to admin_users_path, :message => "Unabled to delete comment"
    end
  end
end