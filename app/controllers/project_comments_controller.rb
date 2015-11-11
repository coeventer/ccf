class ProjectCommentsController < OrganizationController
  before_filter :verification_required
  before_action :project_lookup
  respond_to :js

  def create
    authorize! :create, @project.comments.new
    @comment = ProjectComment.create(project_id: @project.id, user: current_user, description: project_comment_params[:description])
  end

  def destroy
    @comment = @project.comments.find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy
  end

  private 

  def project_lookup
    @project = Project.find(params[:project_id])
  end

  def project_comment_params
    params.require(:project_comment).permit(:description)
  end
end
