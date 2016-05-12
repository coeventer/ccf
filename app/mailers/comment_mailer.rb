class CommentMailer < ActionMailer::Base
  helper :CommentMailer

  default :from => "no-reply@#{APP_CONFIG['mail']['domain']}"
  def comment_posted(project_comment, user)
    @project = project_comment.project

    @user = user
    @comment = project_comment
    @subdomain = @project.organization.subdomain if @project.organization
    mail(:to => user.email, :subject => "New Comment From #{@comment.user.name} in \"#{@project.title}\"") do |format|
      format.text
      format.html
    end
  end
end
