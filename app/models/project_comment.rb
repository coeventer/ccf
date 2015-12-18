class ProjectComment < ActiveRecord::Base
  include SlackNotifiable

  attr_accessible :description, :project_id, :title, :user
  validates :description, presence: true

  belongs_to :user
  belongs_to :project, counter_cache: true
  has_one :organization, through: :project

  after_create :send_notification

  delegate :id, to: :organization, prefix: true

  default_scope { order(:created_at)}

  def slack_message
    "#{user.name} has commented on #{project.title}: #{description}"
  end

  def send_notification
    CommentMailer.comment_posted(self).deliver_now
  end
end
