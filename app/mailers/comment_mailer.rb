# require 'mail'
class CommentMailer < ActionMailer::Base
  default :from => "ccf@umn.edu"
  def comment_posted(project, comment)
    get_project_users(project).each do |user|
      @user = user
      @comment = comment
      @project = project
      mail = mail(:to => user.email, :subject => "New Comment For \"#{project.title}\"") do |format|
        format.text
        format.html
      end
      mail.deliver
    end
  end

  def get_project_users(project)
    users = []
    users << project.project_owner unless project.project_owner.alert_when_owner == false
    project.comments.each do |comment|
      if comment.user.alert_when_commenter == true
        users << comment.user
      end
    end
    users.uniq
  end
end
