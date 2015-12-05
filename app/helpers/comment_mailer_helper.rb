module CommentMailerHelper
  def self.get_project_users(project)
    users = []
    users << project.project_owner if project.project_owner.send_notifications?
    project.comments.each do |comment|
      users << comment.user if comment.user.send_notifications?
    end
    return users.uniq
  end
end