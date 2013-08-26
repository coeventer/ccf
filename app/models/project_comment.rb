class ProjectComment < ActiveRecord::Base
  attr_accessible :description, :project_id, :title, :user

  belongs_to :user
  belongs_to :project
end
