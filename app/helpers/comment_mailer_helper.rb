module CommentMailerHelper
  def self.get_project_users(project)
    ( project.project_owner.send_notifications? ? [project.project_owner] : [] ) | User.project_notifiable(project.id).to_a
  end
end
