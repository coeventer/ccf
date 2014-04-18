class ProjectCommentsController < ApplicationController
  before_filter :verification_required
  def create
    @project = Project.find(params[:project_id])
    @user = current_user
    @comment = @project.comments.new(params[:project_comment])
    @comment.user = current_user
    @comment.save
     
     respond_to do |format|
       format.js
     end
  end
end
