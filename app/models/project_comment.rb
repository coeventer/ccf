class ProjectComment < ActiveRecord::Base
  attr_accessible :description, :project_id, :title, :user_id
end
