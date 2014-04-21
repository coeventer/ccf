class ProjectComment < ActiveRecord::Base
  attr_accessible :description, :project_id, :title, :user
  validates :description, presence: true

  belongs_to :user
  belongs_to :project
end
