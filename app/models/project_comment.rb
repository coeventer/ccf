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

  def url
    Rails.application.routes.url_helpers.project_project_comment_url(project_id,id)
  end

  def slack_message
    "#{user.name} has commented on #{project.title}: #{url}"
  end

  def send_notification
    CommentMailerHelper.get_project_users(self.project).each do |user|
      CommentMailer.comment_posted(self, user).deliver_now
    end
  end
end
