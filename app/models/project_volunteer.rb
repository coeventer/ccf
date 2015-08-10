class ProjectVolunteer < ActiveRecord::Base
  include SlackNotifiable

  attr_accessible :interest_level, :project_id, :user_id

  belongs_to :project, counter_cache: true
  belongs_to :user
  has_one :organization, through: :project

  validate :limit_projects, if: "new_record?"

  delegate :name, :image, to: :user, prefix: true

  default_scope { order(:created_at)}

  def limit_projects
    if project.event.projects.joins(:volunteers).where(project_volunteers: {user_id: user.id}).count >= 2 then
      errors[:base] << "You may only help with two projects during an event"
    end
  end

  def slack_message
    "#{user.name} has volunteered for #{project.title}"
  end
end
