class ProjectRating < ActiveRecord::Base
  include SlackNotifiable

  attr_accessible :project_id, :rating, :user_id

  belongs_to :project, counter_cache: true
  belongs_to :user
  has_one :organization, through: :project

  delegate :id, to: :organization, prefix: true

  def slack_message
    "#{user.name} liked project: #{project.title}"
  end
end
