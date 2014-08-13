class ProjectCommentsController < OrganizationController
  before_filter :verification_required
  def create
    @project = Project.find(params[:project_id])

    authorize! :create, @project.comments.new
    @comment = @project.comments.new(params[:project_comment])
    @comment.user = current_user
    @comment.save

    @project = Project.find(params[:project_id])
    CommentMailer.comment_posted(@project, @comment)

    respond_to do |format|
     format.js
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @comment = @project.comments.find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy

    respond_to do |format|
      format.js
    end
  end
end
