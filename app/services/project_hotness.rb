class ProjectHotness
  attr_accessor :project
  delegate :created_at, :project_comments_count, :project_ratings_count, :project_volunteers_count, to: :project

  def initialize(project)
    self.project = project
  end

  def hotness
    created_halflife_multiplier * activity_total
  end

  private

  def created_days_ago
    @created_days_ago ||= (Date.today - created_at.to_date).to_i
  end

  def created_halflife_multiplier
    return 1 if created_days_ago <= decay_rate + 2
     
     1 / Math.log(created_days_ago - decay_rate)
  end

  def activity_total
    total = project_comments_count + project_ratings_count + project_volunteers_count
    total > 0 ? total : 1
  end

  def decay_rate
    4
  end
end
