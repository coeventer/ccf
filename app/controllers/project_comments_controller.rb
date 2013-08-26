class ProjectCommentsController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    
    @comment = @project.comments.create(params[:project_comment])
     
     respond_to do |format|
       format.js
     end
  end
end
