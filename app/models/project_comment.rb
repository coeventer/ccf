class ProjectComment < ActiveRecord::Base
  include SlackNotifiable

  attr_accessible :description, :project_id, :title, :user
  validates :description, presence: true

  belongs_to :user
  belongs_to :project, counter_cache: true
  has_one :organization, through: :project

  delegate :id, to: :organization, prefix: true

  default_scope { order(:created_at)}

  def slack_message
    "#{user.name} has commented on #{project.title}: #{description}"
  end
end
