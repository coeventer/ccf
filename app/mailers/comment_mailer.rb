class CommentMailer < ActionMailer::Base
  helper :CommentMailer

  default :from => "no-reply@#{APP_CONFIG['mail']['domain']}"
  def comment_posted(project_comment)
    @project = project_comment.project
    CommentMailerHelper.get_project_users(@project).each do |user|
      @user = user
      @comment = project_comment
      @subdomain = @project.organization.subdomain if @project.organization
      mail(:to => user.email, :subject => "New Comment For \"#{@project.title}\"") do |format|
        format.text
        format.html
      end
    end
  end
end
