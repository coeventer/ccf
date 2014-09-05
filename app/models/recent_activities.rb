class RecentActivities
  attr_accessor :event_id, :recent_activies
  RecentActivity = Struct.new(:user_id, :user_name, :action, :title, :project_id)
  def initialize(event_id)
    self.event_id = event_id
  end

  def all
    @recent_activities ||= begin
      ActiveRecord::Base.connection.execute(recent_activities_query(event_id)).collect do |row|
        RecentActivity.new(*row)
      end
    end
  end

  # This will probably need to be optimized as the data grows
  def recent_activities_query(event_id)
    "
    select users.id, users.name, recent_activities.action, recent_activities.title, recent_activities.project_id
    from
      (select 'added' as action, project_owner_id as user_id, title, created_at, id as project_id from projects where event_id=#{event_id}
      UNION ALL
      select 'commented on', user_id, projects.title, project_comments.created_at, project_id from project_comments inner join projects on project_comments.project_id = projects.id where projects.event_id=#{event_id}
      UNION ALL
      select 'volunteered for', user_id, projects.title, project_volunteers.created_at, project_id from project_volunteers inner join projects on project_volunteers.project_id = projects.id where projects.event_id=#{event_id}
      UNION ALL 
      select 'liked', user_id, projects.title, project_ratings.created_at, project_id from project_ratings inner join projects on project_ratings.project_id = projects.id where projects.event_id=#{event_id}
      order by created_at desc limit 10) recent_activities
      inner join users on recent_activities.user_id = users.id
    "
  end
  private :recent_activities_query
end