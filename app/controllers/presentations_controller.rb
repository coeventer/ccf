class PresentationsController < OrganizationController
  skip_before_filter :auth_required, :only => [:show]
  before_filter :load_presentation
  layout 'presentation'
  def show
    @next_up = @project.event.projects[@project.event.projects.index(@project)+1]
  end

  def edit

  end

  def update
    @presentation.update_attributes(presentation_params)
    
    respond_to do |format|
      format.html {redirect_to project_presentation_path(@project)}
      format.json {render :show}
    end
  end

  def load_presentation
    @project = Project.find(params[:project_id])
    @presentation = @project.presentation
    redirect_to project_path(@project) unless @project.event
  end
  private :load_presentation

  def presentation_params
    params.require(:presentation).permit(:why, :what, :right, :wrong, :next_steps)
  end
  private :presentation_params
end
