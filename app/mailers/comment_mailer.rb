class CommentMailer < ActionMailer::Base
  default :from => "no-reply@#{APP_CONFIG['mail']['domain']}"
  def comment_posted(project, comment)
    get_project_users(project).each do |user|
      @user = user
      @comment = comment
      @project = project
      @subdomain = @project.organization.subdomain if @project.event.organization
      mail = mail(:to => user.email, :subject => "New Comment For \"#{project.title}\"") do |format|
        format.text
        format.html
      end
      mail.deliver
    end
  end

  def get_project_users(project)
    users = []
    users << project.project_owner if project.project_owner.send_notifications?
    project.comments.each do |comment|
      users << comment.user if comment.user.send_notifications?
    end
    users.uniq
  end
end
